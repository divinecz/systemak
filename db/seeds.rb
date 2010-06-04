# encoding: utf-8

Device.create!(:name => "Testovací modul", :ip_address => "192.168.1.1", :online => true)
Activity.create!([
  { :name => "Solárium", :hardware_id => 1 },
  { :name => "Posilovna", :hardware_id => 2 },
  { :name => "Box", :hardware_id => 3 },
  { :name => "Squash", :hardware_id => 4 },
  { :name => "Ricochet", :hardware_id => 5 },
  { :name => "Ping pong", :hardware_id => 6 },
  { :name => "Badminton", :hardware_id => 7 },
  { :name => "Spinning", :hardware_id => 8 },
  { :name => "Aerobic", :hardware_id => 9 },
  { :name => "Beach volejbal", :hardware_id => 10 }
  ])
