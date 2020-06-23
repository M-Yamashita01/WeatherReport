# frozen_string_literal: true

json.set! :location do
  json.array! @location do |location|
    json.extract! location, :location_id, :prefecture_name, :location_name, :longitude, :latitude
  end
end
