# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101112100002) do

  create_table "devices", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                    :limit => 30, :null => false
    t.string   "ip_address",              :limit => 15, :null => false
    t.integer  "start_log_address"
    t.integer  "end_log_address"
    t.integer  "current_log_address"
    t.date     "last_captured_date"
    t.datetime "last_communication_at"
    t.integer  "last_communication_took"
    t.string   "current_state",                         :null => false
  end

  add_index "devices", ["current_state"], :name => "index_devices_on_current_state"
  add_index "devices", ["ip_address"], :name => "index_devices_on_ip_address", :unique => true
  add_index "devices", ["name"], :name => "index_devices_on_name", :unique => true

  create_table "error_messages", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_id",   :null => false
    t.string   "title",       :null => false
    t.text     "description", :null => false
  end

  add_index "error_messages", ["device_id"], :name => "index_error_messages_on_device_id"

  create_table "packets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_id",   :null => false
    t.integer  "address",     :null => false
    t.binary   "raw_data",    :null => false
    t.integer  "sequence_id", :null => false
  end

  add_index "packets", ["device_id", "sequence_id"], :name => "index_packets_on_device_id_and_sequence_id", :unique => true
  add_index "packets", ["device_id"], :name => "index_logs_on_device_id"

end
