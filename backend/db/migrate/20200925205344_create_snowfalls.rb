class CreateSnowfalls < ActiveRecord::Migration[5.2]
  def change
    create_table :snowfalls do |t|
      t.float :snow_volume_last_hour
      t.float :snow_volume
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
