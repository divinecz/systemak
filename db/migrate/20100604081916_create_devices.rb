class CreateDevices < ActiveRecord::Migration
  def self.up
    create_table :devices do |t|
      t.timestamps
      t.string     :name,                   :null => false, :limit => 30
      t.string     :ip_address,             :null => false, :limit => 15
      t.boolean    :online,                 :null => false, :default => false
      t.integer    :start_log_address
      t.integer    :end_log_address
      t.integer    :current_log_address
      t.date       :last_captured_date
      t.datetime   :last_communication_at
      t.integer    :last_communication_took
    end

    add_index :devices, :name, :unique => true
    add_index :devices, :ip_address, :unique => true
  end

  def self.down
    drop_table :devices
  end
end
