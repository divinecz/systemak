class Device < ActiveRecord::Base

  has_many :logs, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 30 }
  validates :ip_address, :presence => true, :uniqueness => true, :format => /^(\d{1,3}\.){3}\d{1,3}$/
  validates :online, :inclusion => [true, false]

  def to_s
    self.name
  end

end
