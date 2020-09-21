# frozen_string_literal: true

# class CreateWeatherGroups < ActiveRecord::Migration[5.2]
class CreateWeatherGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :weather_groups do |t|
      t.integer :weather_group_id, null: false
      t.string :weather_icon, null: false
      t.string :weather_main, null: false
      t.string :weather_description, null: false

      t.timestamps
    end
  end
end
