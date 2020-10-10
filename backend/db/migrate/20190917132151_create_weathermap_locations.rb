# frozen_string_literal: true

# class CreateWeathermapLocations < ActiveRecord::Migration[5.2]
class CreateWeathermapLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :weathermap_locations do |t|
      t.integer :city_id, null: false
      t.decimal :latitude, precision: 6, scale: 3, null: false
      t.decimal :longitude, precision: 5, scale: 3, null: false
      t.string :city_name, null: false

      t.timestamps
    end
  end
end
