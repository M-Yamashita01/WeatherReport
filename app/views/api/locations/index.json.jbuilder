json.set! :location do
  json.array! @location do |location|
    json.extract! location, :location_id, :prefecture_name
  end
end
