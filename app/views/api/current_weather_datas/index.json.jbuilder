json.set! :current_weather_data do
  json.array! @current_weather_data do |weather_data|
    json.extract! weather_data, :city_id, :city_name, :latitude, :longitude, :weather_icon
  end
end
