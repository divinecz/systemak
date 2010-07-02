# encoding: utf-8
class Packet < ActiveRecord::Base

  belongs_to :device

  validates :device_id, :presence => true
  validates :address, :presence => true
  validates :raw_data, :presence => true
  
  def to_sproutcore_hash
    {
      :id => self.id,
      :device => self.device_id,
      :created_at => self.created_at,
      :address => self.address.to_address,
      :data => self.raw_data.unpack("H*").first
    }
  end

end
