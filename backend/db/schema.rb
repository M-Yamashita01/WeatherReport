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

ActiveRecord::Schema.define(version: 2019_09_17_135415) do

  create_table "articles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "commenter"
    t.text "body"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "current_weather_datas", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.datetime "acquired_datetime", null: false
    t.bigint "weathermap_location_id", null: false
    t.integer "weather_group_id", null: false
    t.float "temperature", null: false
    t.float "pressure", null: false
    t.integer "humidity", null: false
    t.float "temperature_min", null: false
    t.float "temperature_max", null: false
    t.float "wind_speed", null: false
    t.float "wind_degree", null: false
    t.integer "cloudiness", null: false
    t.float "rain_1h"
    t.float "rain_3h"
    t.float "snow_1h"
    t.float "snow_3h"
    t.bigint "sunrise"
    t.bigint "sunset"
    t.string "country_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["weather_group_id"], name: "index_current_weather_datas_on_weather_group_id"
    t.index ["weathermap_location_id"], name: "index_current_weather_datas_on_weathermap_location_id"
  end

  create_table "location_on_forecast_days", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "location_id", null: false
    t.datetime "weather_last_update_datetime", null: false
    t.date "forecast_day", null: false
    t.integer "weather_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_location_on_forecast_days_on_location_id"
    t.index ["weather_id"], name: "index_location_on_forecast_days_on_weather_id"
  end

  create_table "locations", primary_key: "location_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "area_name", null: false
    t.string "prefecture_name", null: false
    t.string "location_name", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.boolean "main_city_flag", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "weather_groups", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "weather_group_id", null: false
    t.string "weather_icon", null: false
    t.string "weather_main", null: false
    t.string "weather_description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weathermap_locations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "city_id", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "city_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "weathers", primary_key: "weather_id", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
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