class Sensor < ActiveRecord::Base

  belongs_to :location
  belongs_to :device

  validates :location_id, :presence => true
  validates :device_id, :presence => true
  validates :sensor_number, :presence => true, :uniqueness => { :scope => [:location_id, :device_id] }, :numericality => true,
  :inclusion => { :in => 0..3 }

end
