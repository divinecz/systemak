class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.timestamps
      t.string     :name,        :null => false, :limit => 30
      t.integer    :hardware_id, :null => false, :limit => 2
    end

    add_index :activities, :name, :unique => true
    add_index :activities, :hardware_id, :unique => true
  end

  def self.down
    drop_table :activities
  end
end
