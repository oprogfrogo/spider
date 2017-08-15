# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170614062020) do

  create_table "agents", force: :cascade do |t|
    t.string   "login",       limit: 255
    t.string   "password",    limit: 255
    t.string   "name",        limit: 255
    t.string   "email",       limit: 255
    t.string   "phone",       limit: 255
    t.string   "ext",         limit: 255
    t.boolean  "is_manager"
    t.boolean  "round_robin"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "autos", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "vin",        limit: 255
    t.integer  "year",       limit: 4
    t.string   "make",       limit: 255
    t.string   "model",      limit: 255
    t.string   "token",      limit: 255
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "autos", ["user_id"], name: "index_autos_on_user_id", using: :btree

  create_table "homes", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "street",       limit: 255
    t.string   "street2",      limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "postal_code",  limit: 255
    t.string   "year_built",   limit: 255
    t.boolean  "alarm_system"
    t.string   "token",        limit: 255
    t.string   "status",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "homes", ["user_id"], name: "index_homes_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "name",           limit: 255
    t.string   "phone_number",   limit: 255
    t.string   "email",          limit: 255
    t.string   "street",         limit: 255
    t.string   "street2",        limit: 255
    t.string   "city",           limit: 255
    t.string   "state",          limit: 255
    t.string   "postal_code",    limit: 255
    t.date     "dob"
    t.string   "dl_number",      limit: 255
    t.string   "martial_status", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "quotes_autos", force: :cascade do |t|
    t.integer  "auto_id",                          limit: 4
    t.string   "category",                         limit: 255
    t.string   "carrier",                          limit: 255
    t.string   "bodily_injury_liability",          limit: 255
    t.string   "property_damage_liability",        limit: 255
    t.string   "medical_payments",                 limit: 255
    t.string   "uninsured_motorist_bodily_injury", limit: 255
    t.string   "comprehensive",                    limit: 255
    t.string   "collision",                        limit: 255
    t.string   "waiver_of_collision_deductible",   limit: 255
    t.string   "rental_reimbursement",             limit: 255
    t.string   "roadside_coverage",                limit: 255
    t.string   "total_premium",                    limit: 255
    t.integer  "agent_id",                         limit: 4
    t.integer  "rating",                           limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "quotes_autos", ["auto_id"], name: "index_quotes_autos_on_auto_id", using: :btree

  create_table "quotes_homes", force: :cascade do |t|
    t.integer  "home_id",                               limit: 4
    t.string   "dwelling_limit",                        limit: 255
    t.string   "dwelling_premium",                      limit: 255
    t.string   "personal_property_limit",               limit: 255
    t.string   "personal_property_premium",             limit: 255
    t.string   "loss_of_use_limit",                     limit: 255
    t.string   "loss_of_use_premium",                   limit: 255
    t.string   "liability_limit",                       limit: 255
    t.string   "liability_premium",                     limit: 255
    t.string   "medical_payments_limit",                limit: 255
    t.string   "medical_payments_premium",              limit: 255
    t.string   "deductible_limit",                      limit: 255
    t.string   "deductible_premium",                    limit: 255
    t.string   "premises_alarm_fire_system_limit",      limit: 255
    t.string   "premises_alarm_fire_system_premium",    limit: 255
    t.string   "contents_other_residents_limit",        limit: 255
    t.string   "contents_other_residents_premium",      limit: 255
    t.string   "unscheduled_personal_property_limit",   limit: 255
    t.string   "unscheduled_personal_property_premium", limit: 255
    t.string   "jewels_watches_furs_limit",             limit: 255
    t.string   "jewels_watches_furs_premium",           limit: 255
    t.string   "money_limit",                           limit: 255
    t.string   "money_premium",                         limit: 255
    t.string   "securities_limit",                      limit: 255
    t.string   "securities_premium",                    limit: 255
    t.string   "silver_gold_pewter_limit",              limit: 255
    t.string   "silver_gold_pewter_premium",            limit: 255
    t.string   "firearms_limit",                        limit: 255
    t.string   "firearms_premium",                      limit: 255
    t.string   "electronic_app_vehicles_limit",         limit: 255
    t.string   "electronic_app_vehicles_premium",       limit: 255
    t.string   "electronic_app_business_limit",         limit: 255
    t.string   "electronic_app_business_premium",       limit: 255
    t.string   "workers_compensation_limit",            limit: 255
    t.string   "workers_compensation_premium",          limit: 255
    t.string   "inflation_guard_limit",                 limit: 255
    t.string   "inflation_guard_premium",               limit: 255
    t.string   "ordinance_or_law_converage_limit",      limit: 255
    t.string   "ordinance_or_law_converage_premium",    limit: 255
    t.string   "replace_cost_contents_limit",           limit: 255
    t.string   "replace_cost_contents_premium",         limit: 255
    t.string   "fungi_mold_bacteria_limit",             limit: 255
    t.string   "fungi_mold_bacteria_premium",           limit: 255
    t.string   "total_premium_limit",                   limit: 255
    t.string   "total_premium_premium",                 limit: 255
    t.integer  "agent_id",                              limit: 4
    t.integer  "rating",                                limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "quotes_homes", ["home_id"], name: "index_quotes_homes_on_home_id", using: :btree

  create_table "registrations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.string   "token",      limit: 255
    t.string   "confirmed",  limit: 255, default: "N"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_foreign_key "profiles", "users"
  add_foreign_key "quotes_autos", "autos"
  add_foreign_key "quotes_homes", "homes"
end
