# frozen_string_literal: true

# class AddJapaneseLocationNameToWeathermapLocations
#                               < ActiveRecord::Migration[5.2]
class AddJapaneseLocationNameToWeathermapLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :weathermap_locations, :city_name_ja, :string
  end
end
