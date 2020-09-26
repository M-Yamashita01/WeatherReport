class CreateUvIndices < ActiveRecord::Migration[5.2]
  def change
    create_table :uv_indices do |t|
      t.float :midday_uv_index
      t.references :forecast, null: false

      t.timestamps
    end
  end
end
