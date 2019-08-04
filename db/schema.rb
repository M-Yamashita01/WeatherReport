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

ActiveRecord::Schema.define(version: 2019_08_01_125137) do

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "location_on_forecast_days", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "location_id", null: false
    t.datetime "weather_last_update_datetime", null: false
    t.date "forecast_day", null: false
    t.integer "weather_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_location_on_forecast_days_on_location_id"
    t.index ["weather_id"], name: "index_location_on_forecast_days_on_weather_id"
  end

  create_table "locations", primary_key: "location_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "area_name", null: false
    t.string "prefecture_name", null: false
    t.string "location_name", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.boolean "main_city_flag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weathers", primary_key: "weather_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "date_label", null: false
    t.string "telop_weather", null: false
    t.string "weather_image_link", null: false
    t.integer "highest_temperature", null: false
    t.integer "lowest_temperature", null: false
    t.string "weather_url", null: false
    t.datetime "weather_announcement_datetime", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "articles"
  add_foreign_key "location_on_forecast_days", "locations", primary_key: "location_id"
  add_foreign_key "location_on_forecast_days", "weathers", primary_key: "weather_id"
end
