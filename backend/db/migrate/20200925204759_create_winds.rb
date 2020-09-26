class CreateWinds < ActiveRecord::Migration[5.2]
  def change
    create_table :winds do |t|
      t.float :wind_speed
      t.float :wind_gust
      t.integer :wind_direction
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
