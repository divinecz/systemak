class ErrorMessage < ActiveRecord::Base

  belongs_to :device

  validates :device_id, :presence => true
  validates :title, :presence => true
  validates :message, :presence => true

end
