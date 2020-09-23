class CreateSunrisesets < ActiveRecord::Migration[5.2]
  def change
    create_table :sunrisesets do |t|
      t.datetime :sunrise_at
      t.datetime :sunset_at 
      t.references :forecast, null: false, foreign_key: true

      t.timestamps
    end
  end
end
