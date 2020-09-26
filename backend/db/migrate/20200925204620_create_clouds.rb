class CreateClouds < ActiveRecord::Migration[5.2]
  def change
    create_table :clouds do |t|
      t.integer :cloudiness
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
