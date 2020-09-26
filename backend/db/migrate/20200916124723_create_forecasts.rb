class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.text :forecast_type, null: false
      t.references :weathermap_location, null: false, foreign_key: true
      t.timestamps
    end
  end
end
