class CreateCurrentWeatherDatas < ActiveRecord::Migration[5.2]
  def change
    create_table :current_weather_datas do |t|
      t.datetime :acquired_datetime, null: false
      t.references :weathermap_location, type: :bigint, null: false
      t.references :weather_group, type: :integer, null: false
      t.float :temperature, null: false
      t.float :pressure, null: false
      t.integer :humidity, null: false
      t.float :temperature_min, null: false
      t.float :temperature_max, null: false
      t.float :wind_speed, null: false
      t.float :wind_degree, null: false
      t.integer :cloudiness, null: false
      t.float :rain_1h
      t.float :rain_3h
      t.float :snow_1h
      t.float :snow_3h
      t.integer :sunrise, limit: 8
      t.integer :sunset, limit: 8
      t.string :country_code, null: false

      t.timestamps
    end
    # add_foreign_key :current_weather_datas, :weathermap_locations
    # add_foreign_key :current_weather_datas, :weather_groups
  end
end
