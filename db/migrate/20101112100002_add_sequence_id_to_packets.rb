class AddSequenceIdToPackets < ActiveRecord::Migration
  def self.up
    add_column :packets, :sequence_id, :integer
    Device.all.each do |device|
      device.packets.each_with_index do |packet, index|
        packet.update_attribute(:sequence_id, index)
      end
    end
    change_column :packets, :sequence_id, :integer, :null => false
    add_index :packets, [:device_id, :sequence_id], :unique => true
  end

  def self.down
    remove_column :packets, :sequence_id
  end
end
