json.set! :location do
  json.array! @location do |location|
    json.extract! location, :prefecture_name
  end
end
