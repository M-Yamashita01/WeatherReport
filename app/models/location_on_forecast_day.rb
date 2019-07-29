class LocationOnForecastDay < ApplicationRecord
  has_many :locations, foreign_key: :location_id, primary_key: :location_id
  has_many :weathers, foreign_key: :weather_id, primary_key: :weather_id
end
