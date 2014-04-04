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

ActiveRecord::Schema.define(version: 20131010090254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "committees_languages", id: false, force: true do |t|
    t.integer "committee_id"
    t.integer "language_id"
  end

  add_index "committees_languages", ["committee_id", "language_id"], name: "index_committees_languages_on_committee_id_and_language_id", unique: true, using: :btree

  create_table "countries", force: true do |t|
    t.string  "name",        null: false
    t.string  "code",        null: false
    t.integer "language_id"
  end

  add_index "countries", ["code"], name: "index_countries_on_code", unique: true, using: :btree
  add_index "countries", ["language_id"], name: "index_countries_on_language_id", using: :btree
  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "exams", force: true do |t|
    t.integer  "language_id"
    t.datetime "datetime"
    t.integer  "min"
    t.integer  "max"
    t.string   "state"
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exams", ["committee_id"], name: "index_exams_on_committee_id", using: :btree
  add_index "exams", ["language_id"], name: "index_exams_on_language_id", using: :btree

  create_table "faculties", force: true do |t|
    t.string   "name"
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faculties", ["committee_id", "name"], name: "index_faculties_on_committee_id_and_name", unique: true, using: :btree
  add_index "faculties", ["committee_id"], name: "index_faculties_on_committee_id", using: :btree

  create_table "faqs", force: true do |t|
    t.string   "question",     limit: 1000,                 null: false
    t.text     "answer",                                    null: false
    t.integer  "position"
    t.boolean  "published",                 default: false
    t.boolean  "public",                    default: false
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "field_of_studies", force: true do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "field_of_studies", ["faculty_id", "name"], name: "index_field_of_studies_on_faculty_id_and_name", unique: true, using: :btree
  add_index "field_of_studies", ["faculty_id"], name: "index_field_of_studies_on_faculty_id", using: :btree

  create_table "language_grades", force: true do |t|
    t.integer  "user_id"
    t.integer  "language_id"
    t.float    "grade"
    t.integer  "year"
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "exam_id"
  end

  add_index "language_grades", ["exam_id"], name: "index_language_grades_on_exam_id", using: :btree
  add_index "language_grades", ["language_id", "user_id", "year"], name: "index_language_grades_on_language_id_and_user_id_and_year", unique: true, using: :btree
  add_index "language_grades", ["language_id", "user_id"], name: "index_language_grades_on_language_id_and_user_id", using: :btree
  add_index "language_grades", ["language_id"], name: "index_language_grades_on_language_id", using: :btree
  add_index "language_grades", ["user_id"], name: "index_language_grades_on_user_id", using: :btree

  create_table "languages", force: true do |t|
    t.string "name",               null: false
    t.string "iso_code", limit: 3, null: false
  end

  add_index "languages", ["iso_code"], name: "index_languages_on_iso_code", unique: true, using: :btree
  add_index "languages", ["name"], name: "index_languages_on_name", unique: true, using: :btree

  create_table "pages", force: true do |t|
    t.string   "slug",                      null: false
    t.string   "title",                     null: false
    t.boolean  "public",     default: true
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

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
    t.string   "name",         null: false
    t.string   "value",        null: false
    t.integer  "year",         null: false
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["committee_id", "year", "name"], name: "index_settings_on_committee_id_and_year_and_name", unique: true, using: :btree
  add_index "settings", ["committee_id"], name: "index_settings_on_committee_id", using: :btree

  create_table "specializations", force: true do |t|
    t.string   "name"
    t.integer  "field_of_study_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "specializations", ["field_of_study_id", "name"], name: "index_specializations_on_field_of_study_id_and_name", unique: true, using: :btree
  add_index "specializations", ["field_of_study_id"], name: "index_specializations_on_field_of_study_id", using: :btree

  create_table "stages", force: true do |t|
    t.string   "name",         null: false
    t.string   "full_name",    null: false
    t.text     "description",  null: false
    t.datetime "deadline",     null: false
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stages", ["committee_id", "name"], name: "index_stages_on_committee_id_and_name", unique: true, using: :btree
  add_index "stages", ["committee_id"], name: "index_stages_on_committee_id", using: :btree

  create_table "subject_grades", force: true do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.float    "grade"
    t.float    "ects"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "subject_grades", ["subject_id"], name: "index_subject_grades_on_subject_id", using: :btree
  add_index "subject_grades", ["user_id"], name: "index_subject_grades_on_user_id", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.integer  "committee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subjects", ["committee_id", "name"], name: "index_subjects_on_committee_id_and_name", unique: true, using: :btree
  add_index "subjects", ["committee_id"], name: "index_subjects_on_committee_id", using: :btree

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
