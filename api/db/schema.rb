# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_28_205440) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "owners", force: :cascade do |t|
    t.text "name"
    t.integer "age"
    t.text "city"
    t.bigint "identificationNumber"
    t.bigint "phone"
    t.bigint "wins"
    t.bigint "loses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "lastName"
  end

  create_table "people", force: :cascade do |t|
    t.string "firstName"
    t.text "lastName"
    t.integer "phoneNumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roosters", force: :cascade do |t|
    t.text "name"
    t.integer "breed_id"
    t.integer "color_id"
    t.integer "wins"
    t.integer "loses"
    t.integer "strength"
    t.integer "resistance"
    t.integer "agility"
    t.integer "defence"
    t.integer "owners_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
