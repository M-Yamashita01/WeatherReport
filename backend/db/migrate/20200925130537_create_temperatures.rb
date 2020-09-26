class CreateTemperatures < ActiveRecord::Migration[5.2]
  def change
    create_table :temperatures do |t|
      t.float :temperature
      t.float :morning_temperature
      t.float :daytime_temperature
      t.float :evening_temperature
      t.float :night_temperature
      t.float :maximum_temperature
      t.float :minimum_temperature
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
