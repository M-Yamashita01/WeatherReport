class CreateAtmosphericPressures < ActiveRecord::Migration[5.2]
  def change
    create_table :atmospheric_pressures do |t|
      t.integer :atmospheric_pressure
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
