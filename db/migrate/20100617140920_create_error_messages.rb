class CreateErrorMessages < ActiveRecord::Migration
  def self.up
    create_table :error_messages do |t|
      t.timestamps
      t.integer    :device_id,   :null => false
      t.string     :title,       :null => false
      t.text       :description, :null => false
    end

    add_index :error_messages, :device_id

    rename_table :logs, :packets

    remove_column :devices, :online
    add_column :devices, :current_state, :string, :null => false
    add_index :devices, :current_state
  end

  def self.down
    drop_table :error_messages
    rename_table :packets, :logs

    add_column :devices, :online, :boolean, :null => false, :default => false
    remove_column :devices, :current_state
  end
end
