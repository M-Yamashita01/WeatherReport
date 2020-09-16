class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|

      t.timestamps
      t.text :forecast_type
    end
  end
end
