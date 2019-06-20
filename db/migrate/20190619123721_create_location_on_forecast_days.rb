class CreateLocationOnForecastDays < ActiveRecord::Migration[5.2]
  def change
    create_table :location_on_forecast_days do |t|
      t.references :location, type: :integer, limit: 4, null: false
      t.datetime :weather_last_update_datetime, null: false
      t.date :forecast_day, null: false
      t.references :weather, type: :integer, limit: 4, null: false

      t.timestamps
    end
    add_foreign_key :location_on_forecast_days, :locations, column: :location_id, primary_key: :location_id
    add_foreign_key :location_on_forecast_days, :weathers, column: :weather_id, primary_key: :weather_id
  end
end

