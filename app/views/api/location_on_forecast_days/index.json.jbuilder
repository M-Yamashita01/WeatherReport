json.set! :location_on_forecast do
  json.array! @location_on_forecast do |location|
    json.extract! location, :id, :location_id
  end
end
