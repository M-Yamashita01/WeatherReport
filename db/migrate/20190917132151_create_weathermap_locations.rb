class CreateWeathermapLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :weathermap_locations do |t|
      t.integer :city_id, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :city_name, null: false

      t.timestamps
    end
  end
end
