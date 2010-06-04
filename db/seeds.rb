# encoding: utf-8

device = Device.create!(:name => "Testovací modul", :ip_address => "192.168.1.1", :online => true)
device.logs.create!(:address => 0, :raw_data => "\0")