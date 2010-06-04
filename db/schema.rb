# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100604091309) do

  create_table "activities", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        :limit => 30, :null => false
    t.integer  "hardware_id", :limit => 2,  :null => false
  end

  add_index "activities", ["hardware_id"], :name => "index_activities_on_hardware_id", :unique => true
  add_index "activities", ["name"], :name => "index_activities_on_name", :unique => true

  create_table "devices", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                    :limit => 30,                    :null => false
    t.string   "ip_address",              :limit => 15,                    :null => false
    t.boolean  "online",                                :default => false, :null => false
    t.integer  "start_log_address"
    t.integer  "end_log_address"
    t.integer  "current_log_address"
    t.date     "last_captured_date"
    t.datetime "last_communication_at"
    t.integer  "last_communication_took"
  end

  add_index "devices", ["ip_address"], :name => "index_devices_on_ip_address", :unique => true
  add_index "devices", ["name"], :name => "index_devices_on_name", :unique => true

  create_table "locations", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",        :limit => 30, :null => false
    t.integer  "activity_id",               :null => false
  end

  add_index "locations", ["activity_id"], :name => "index_locations_on_activity_id"
  add_index "locations", ["name", "activity_id"], :name => "index_locations_on_name_and_activity_id", :unique => true
  add_index "locations", ["name"], :name => "index_locations_on_name"

  create_table "logs", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "device_id",  :null => false
    t.integer  "address",    :null => false
    t.binary   "raw_data",   :null => false
  end

  add_index "logs", ["device_id"], :name => "index_logs_on_device_id"

  create_table "sensors", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",                :null => false
    t.integer  "device_id",                  :null => false
    t.integer  "sensor_number", :limit => 1, :null => false
  end

  add_index "sensors", ["device_id"], :name => "index_sensors_on_device_id"
  add_index "sensors", ["location_id", "device_id", "sensor_number"], :name => "index_sensors_on_location_id_and_device_id_and_sensor_number", :unique => true
  add_index "sensors", ["location_id"], :name => "index_sensors_on_location_id"
  add_index "sensors", ["sensor_number"], :name => "index_sensors_on_sensor_number"

end
