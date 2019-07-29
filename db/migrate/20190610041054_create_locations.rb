class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations, id: false do |t|
      t.integer :location_id, limit: 4, primary_key: true, null: false
      t.string :area_name, null: false
      t.string :prefecture_name, null: false
      t.string :location_name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.boolean :main_city_flag, null: false

      t.timestamps
    end
  end
end
