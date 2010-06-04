class Location < ActiveRecord::Base

  has_many :sensors, :dependent => :destroy
  belongs_to :activity

  validates :name, :presence => true, :uniqueness => { :scope => :activity_id }, :length => { :maximum => 30 }
  validates :activity_id, :presence => true

end
