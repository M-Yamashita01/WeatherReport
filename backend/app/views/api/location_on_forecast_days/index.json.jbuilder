# frozen_string_literal: true

json.set! :location_on_forecast do
  json.array! @location_on_forecast do |location|
    json.extract! location, :location_name, :latitude, :longitude, :weather_image_link
  end
end
