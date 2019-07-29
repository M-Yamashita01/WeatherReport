class LocationOnForecastDay < ApplicationRecord
  belongs_to :location, foreign_key: :location_id, primary_key: :location_id
  belongs_to :weather, foreign_key: :weather_id, primary_key: :weather_id
end
