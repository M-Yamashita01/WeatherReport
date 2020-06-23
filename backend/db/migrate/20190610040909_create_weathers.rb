# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers, id: false do |t|
      t.integer :weather_id, limit: 4, primary_key: true
      t.string :date_label, null: false
      t.string :telop_weather, null: false
      t.string :weather_image_link, null: false
      t.integer :highest_temperature, null: false
      t.integer :lowest_temperature, null: false
      t.string :weather_url, null: false
      t.datetime :weather_announcement_datetime, null: false

      t.timestamps
    end
  end
end
