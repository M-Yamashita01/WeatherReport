class CreateRainfalls < ActiveRecord::Migration[5.2]
  def change
    create_table :rainfalls do |t|
      t.float :rain_volume_last_hour
      t.float :probability_of_precipitation
      t.float :precipitation_of_volume
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
