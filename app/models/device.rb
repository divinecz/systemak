# encoding: utf-8
class Device < ActiveRecord::Base
  
  READ_DELAY = 1000 # ms

  has_many :packets, :dependent => :destroy
  has_many :error_messages, :dependent => :destroy do
    def add(title, description)
      create!(:title => title, :description => description)
    end
  end

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 30 }
  validates :ip_address, :presence => true, :uniqueness => true, :format => /^(\d{1,3}\.){3}\d{1,3}$/

  include AASM
  aasm_column :current_state
  aasm_initial_state :online
  aasm_state :offline, :after_enter => :state_changed
  aasm_state :not_available, :after_enter => :state_changed
  aasm_state :not_responding, :after_enter => :state_changed
  aasm_state :online, :after_enter => :state_changed
  aasm_event :offline do
    transitions :to => :offline, :from => [:online, :not_available]
  end
  aasm_event :not_available do
    transitions :to => :not_available, :from => [:online, :not_responding]
  end
  aasm_event :not_responding do
    transitions :to => :not_responding, :from => [:online]
  end
  aasm_event :online do
    transitions :to => :online, :from => [:not_available, :not_responding, :offline]
  end

  LOG_DEFINITIONS_PATH = Rails.root.join("config", "log_definitions", "uni_log_definitions.yml")
  UNI_LOG_PACKET_SIZE = 8

  def to_s
    self.name
  end

  def current_state_name
    { "offline" => "Offline", "not_available" => "Zařízení je nedostupné", "not_responding" => "Zařízení neodpovídá", "online" => "Online" }[self.current_state]
  end

  def initialized?
    self.start_log_address && self.end_log_address && self.current_log_address
  end

  def reset!
    self.start_log_address = self.end_log_address = self.current_log_address = nil
    save!
  end

  def refresh!
    communication_start = Time.now
    initialize_new! unless initialized?
    if initialized?
      device_current_log_address = self.read_current_log_address
      if device_current_log_address
        while device_current_log_address != self.current_log_address do
          log_address = self.current_log_address
          packet = read_packet
          self.packets.create!(:address => log_address, :raw_data => packet) if packet
          sleep(READ_DELAY / 1000.0)
        end
        self.last_communication_at = communication_start
        self.last_communication_took = (Time.now - communication_start) * 1000
      end
    end
    save!
  end

  protected

  def log_parser
    @log_parser ||= @log_parser = LogParser::UniLogParser.new(LOG_DEFINITIONS_PATH) do
      read_packet
    end
  end

  def reader
    @reader ||= @reader = if Rails.env.development?
      DEVICE_TEST_READER
    else
      DeviceReader::HttpReader.new(self.ip_address)
    end
  end

  def initialize_new!
    status = read_status
    self.start_log_address = status[:start_log_address]
    self.end_log_address = status[:end_log_address]
    self.current_log_address = status[:start_log_address]
    if initialized?
      save!
    else
      self.error_messages.add("Chyba inicializace", "Inicializace nového zařízení se nezdařila.")
    end
  end

  def read_status
    begin
      raw_status = self.reader.raw_status
    rescue Exception => exception
      process_not_responding(exception)
      return
    end
    online! unless online?
    raw_status_lines = raw_status.split("\r\n")
    raw_status_parts = raw_status_lines[0].split(" ")
    {
      :start_log_address => raw_status_parts[0].split(":").last.try(:to_i, 16),
      :end_log_address => raw_status_parts[1].split(":").last.try(:to_i, 16),
      :current_log_address => raw_status_parts[2].split(":").last.try(:to_i, 16)
    }
  end

  def read_packet_from_buffer(log_address)
    if @read_buffer.nil? || @read_buffer_current_log_address > log_address || log_address - @read_buffer_current_log_address > (256 - UNI_LOG_PACKET_SIZE)
      begin
        raw_data = self.reader.raw_read(log_address)
      rescue Exception => exception
        process_not_responding(exception)
        return
      end
      online! unless online?
      returned_address, returned_data = raw_data.split(":").collect(&:strip)
      if returned_address.hex != log_address
        self.error_messages.add("Chyba čtení", "Požadovaná adresa pro čtení #{log_address.to_address} neodpovídá adrese #{returned_address} vrácené zařízením.")
        return
      end
      @read_buffer = returned_data.lines.to_a.pack("H*")
      @read_buffer_current_log_address = log_address
    end
    buffer_current_log_position = log_address - @read_buffer_current_log_address
    @read_buffer[buffer_current_log_position..(buffer_current_log_position + UNI_LOG_PACKET_SIZE - 1)]
  end

  def read_packet
    if initialized?
      self.current_log_address = self.start_log_address if self.current_log_address == self.end_log_address
      packet = read_packet_from_buffer(self.current_log_address)
      if packet
        self.current_log_address = if self.current_log_address + UNI_LOG_PACKET_SIZE == self.end_log_address
          self.start_log_address
        else
          self.current_log_address + UNI_LOG_PACKET_SIZE
        end
      end
      packet
    end
  end

  def read_current_log_address
    status = read_status
    status[:current_log_address] if status
  end

  def process_not_responding(exception)
    if system("ping", "-c 5", self.ip_address)
      not_responding! unless not_responding?
      self.error_messages.add("Zařízení je nedostupné", "Zařízení je nedostupné a neodpovídá na ping.")
      self.error_messages.add("Zařízení neodpovídá", "Chyba #{exception.class.to_s}: #{exception.to_s}")
    else
      not_available! unless not_available?
      self.error_messages.add("Zařízení je nedostupné", "Zařízení je nedostupné a neodpovídá na ping.")
    end
  end

  def state_changed
    Mailer.device_state_changed(self).deliver
  end

end
