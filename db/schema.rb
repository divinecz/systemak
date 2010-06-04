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

ActiveRecord::Schema.define(:version => 20100604081916) do

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

  add_index "devices", ["name"], :name => "index_devices_on_name"

end
