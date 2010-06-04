class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.timestamps
      t.string     :name,        :null => false, :limit => 30
      t.integer    :activity_id, :null => false
    end

    add_index :locations, :name
    add_index :locations, :activity_id
    add_index :locations, [:name, :activity_id], :unique => true
  end

  def self.down
    drop_table :locations
  end
end
