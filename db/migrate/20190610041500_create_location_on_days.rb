class CreateLocationOnDays < ActiveRecord::Migration[5.2]
  def change
    create_table :location_on_days do |t|
      t.references :locations, foreign_key: true, null: false
      t.date :date, null: false
      t.references :weathers, foreign_key: true, null: false

      t.timestamps
    end
  end
end
