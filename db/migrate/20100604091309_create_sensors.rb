class CreateSensors < ActiveRecord::Migration
  def self.up
    create_table :sensors do |t|
      t.timestamps
      t.integer    :location_id,   :null => false
      t.integer    :device_id,     :null => false
      t.integer    :sensor_number, :null => false, :limit => 1
    end

    add_index :sensors, :location_id
    add_index :sensors, :device_id
    add_index :sensors, :sensor_number

    add_index :sensors, [:location_id, :device_id, :sensor_number], :unique => true
  end

  def self.down
    drop_table :sensors
  end
end
