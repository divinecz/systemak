# encoding: utf-8
class Packet < ActiveRecord::Base

  belongs_to :device

  validates :device_id, :presence => true
  validates :address, :presence => true
  validates :raw_data, :presence => true
  validates :sequence_id, :presence => true, :uniqueness => { :scope => :device_id }

  before_validation :assign_sequence_id

  scope :from_sequence_id, lambda { |sequence_id| where("sequence_id >= ?", sequence_id) }

  def to_param
    sequence_id.to_s
  end

  def data
    raw_data.unpack("H*").first
  end

  private

  def assign_sequence_id
    self.sequence_id ||= (device.packets.maximum(:sequence_id) || -1) + 1
  end
end
