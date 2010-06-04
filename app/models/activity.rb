class Activity < ActiveRecord::Base

  has_many :locations, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 30 }
  validates :hardware_id, :presence => true, :uniqueness => true, :numericality => true, :inclusion => { :in => 0..99 }

end
