class Device < ActiveRecord::Base

  has_many :logs, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 30 }
  validates :ip_address, :presence => true, :uniqueness => true, :format => /^(\d{1,3}\.){3}\d{1,3}$/
  validates :online, :inclusion => [true, false]

  LOG_DEFINITIONS_PATH = Rails.root.join("config", "log_definitions", "uni_log_definitions.yml")

  def to_s
    self.name
  end

  def initialized?
    self.start_log_address && self.end_log_address && self.current_log_address
  end

  def reset!
    self.start_log_address = self.end_log_address = self.current_log_address = nil
    save!
  end

  def refresh!
    if self.online?
      initialize_new! unless initialized?
      device_current_log_address = self.read_current_log_address
      while device_current_log_address != self.current_log_address do# && device_current_log_address != self.start_log_address # ?
        @current_log = ""
        log_address = self.current_log_address
        begin
          logger.info self.log_parser.parse.inspect
        rescue LogParser::LogParserError
          self.current_log_address += 7
        end
        self.logs.create!(:address => log_address, :raw_data => @current_log)
      end
      save!
    end
  end

  protected

  def log_parser
    @log_parser ||= @log_parser = LogParser::UniLogParser.new(LOG_DEFINITIONS_PATH) do
      read_byte
    end
  end

  def reader
    @reader ||= @reader = if Rails.env.development?
      DeviceReader::TestReader.new
    else
      DeviceReader::HttpReader.new(self.ip_address)
    end
  end

  def initialize_new!
    status = read_status
    self.start_log_address = status[:start_log_address]
    self.end_log_address = status[:end_log_address]
    self.current_log_address = status[:start_log_address]
    raise "Unable to initialize device" unless initialized?
    save!
  end

  def read_status
    raw_status = self.reader.raw_status
    raw_status_lines = raw_status.split("\r\n")
    raw_status_parts = raw_status_lines[0].split(" ")
    {
      :start_log_address => raw_status_parts[0].split(":").last.try(:to_i, 16),
      :end_log_address => raw_status_parts[1].split(":").last.try(:to_i, 16),
      :current_log_address => raw_status_parts[2].split(":").last.try(:to_i, 16)
    }
  end

  def read_byte_from_buffer(log_address)
    if @read_buffer.nil? || @read_buffer_current_log_address > log_address || log_address - @read_buffer_current_log_address > 256
      returned_address, returned_data = self.reader.raw_read(log_address).split(":").collect(&:strip)
      if returned_address.hex != log_address
        raise "Requested device read address 0x#{log_address.to_address} does not match returned address 0x#{returned_address}"
      end
      @read_buffer = returned_data.lines.to_a.pack("H*")
      @read_buffer_current_log_address = log_address
    end
    @read_buffer.bytes.to_a[log_address - @read_buffer_current_log_address]
  end

  def read_byte
    if initialized?
      self.current_log_address = self.start_log_address if self.current_log_address >= self.end_log_address
      byte = read_byte_from_buffer(self.current_log_address)
      self.current_log_address += 1
      @current_log << byte
      byte
    end
  end

  def read_current_log_address
    read_status[:current_log_address]
  end

end
