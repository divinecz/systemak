class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.timestamps
      t.integer    :device_id, :null => false
      t.integer    :address,   :null => false
      t.binary     :raw_data,  :null => false
    end

    add_index :logs, :device_id
  end

  def self.down
    drop_table :logs
  end
end
