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

ActiveRecord::Schema.define(version: 20130830120359) do

  create_table "cities", force: true do |t|
    t.string  "name",       null: false
    t.integer "country_id"
  end

  add_index "cities", ["country_id", "name"], name: "index_cities_on_country_id_and_name", unique: true, using: :btree
  add_index "cities", ["country_id"], name: "index_cities_on_country_id", using: :btree

  create_table "committees", force: true do |t|
    t.string  "name",    null: false
    t.string  "code"
    t.integer "city_id"
  end

  add_index "committees", ["city_id", "name"], name: "index_committees_on_city_id_and_name", unique: true, using: :btree
  add_index "committees", ["city_id"], name: "index_committees_on_city_id", using: :btree

  create_table "countries", force: true do |t|
    t.string  "name",        null: false
    t.string  "code",        null: false
    t.integer "language_id"
  end

  add_index "countries", ["code"], name: "index_countries_on_code", unique: true, using: :btree
  add_index "countries", ["language_id"], name: "index_countries_on_language_id", using: :btree
  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "faculties", force: true do |t|
    t.string   "name"
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faculties", ["committee_id", "name"], name: "index_faculties_on_committee_id_and_name", unique: true, using: :btree
  add_index "faculties", ["committee_id"], name: "index_faculties_on_committee_id", using: :btree

  create_table "field_of_studies", force: true do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_of_studies", ["faculty_id", "name"], name: "index_field_of_studies_on_faculty_id_and_name", unique: true, using: :btree
  add_index "field_of_studies", ["faculty_id"], name: "index_field_of_studies_on_faculty_id", using: :btree

  create_table "pages", force: true do |t|
    t.string   "slug",                      null: false
    t.string   "title",                     null: false
    t.boolean  "public",     default: true
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "roles", force: true do |t|
    t.string "name"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "sector_groups", force: true do |t|
    t.string "name"
  end

  add_index "sector_groups", ["name"], name: "index_sector_groups_on_name", unique: true, using: :btree

  create_table "sector_priorities", force: true do |t|
    t.integer  "priority"
    t.integer  "sector_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sector_priorities", ["sector_id"], name: "index_sector_priorities_on_sector_id", using: :btree
  add_index "sector_priorities", ["user_id", "priority"], name: "index_sector_priorities_on_user_id_and_priority", unique: true, using: :btree
  add_index "sector_priorities", ["user_id", "sector_id"], name: "index_sector_priorities_on_user_id_and_sector_id", unique: true, using: :btree
  add_index "sector_priorities", ["user_id"], name: "index_sector_priorities_on_user_id", using: :btree

  create_table "sectors", force: true do |t|
    t.string  "name"
    t.integer "sector_group_id"
  end

  add_index "sectors", ["sector_group_id", "name"], name: "index_sectors_on_sector_group_id_and_name", unique: true, using: :btree
  add_index "sectors", ["sector_group_id"], name: "index_sectors_on_sector_group_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "name",       null: false
    t.string   "value",      null: false
    t.integer  "year",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["year", "name"], name: "index_settings_on_year_and_name", unique: true, using: :btree

  create_table "specializations", force: true do |t|
    t.string   "name"
    t.integer  "field_of_study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specializations", ["field_of_study_id", "name"], name: "index_specializations_on_field_of_study_id_and_name", unique: true, using: :btree
  add_index "specializations", ["field_of_study_id"], name: "index_specializations_on_field_of_study_id", using: :btree

  create_table "stages", force: true do |t|
    t.string   "name",        null: false
    t.string   "full_name",   null: false
    t.text     "description", null: false
    t.datetime "deadline",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stages", ["name"], name: "index_stages_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name",                   limit: 50,                         null: false
    t.string   "surname",                limit: 50,                         null: false
    t.string   "email",                  limit: 200,                        null: false
    t.string   "encrypted_password",                 default: "",           null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.integer  "study_year"
    t.date     "birth_date"
    t.string   "student_no"
    t.string   "street"
    t.string   "house"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.integer  "committee_id"
    t.integer  "field_of_study_id"
    t.integer  "specialization_id"
    t.integer  "faculty_id"
    t.string   "state",                              default: "registered", null: false
  end

  add_index "users", ["committee_id", "student_no"], name: "index_users_on_committee_id_and_student_no", unique: true, using: :btree
  add_index "users", ["committee_id"], name: "index_users_on_committee_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["faculty_id"], name: "index_users_on_faculty_id", using: :btree
  add_index "users", ["field_of_study_id"], name: "index_users_on_field_of_study_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["specialization_id"], name: "index_users_on_specialization_id", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
