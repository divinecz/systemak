# encoding: utf-8
class Packet < ActiveRecord::Base

  belongs_to :device

  validates :device_id, :presence => true
  validates :address, :presence => true
  validates :raw_data, :presence => true

end