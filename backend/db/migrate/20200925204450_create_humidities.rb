class CreateHumidities < ActiveRecord::Migration[5.2]
  def change
    create_table :humidities do |t|
      t.integer :humidity
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
