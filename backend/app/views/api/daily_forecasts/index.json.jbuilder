json.set! :daily_forecast do
  json.sunrise_at @daily_forecast.sunrise_at
  json.sunset_at @daily_forecast.sunset_at
  json.temperature @daily_forecast.temperature
  json.atmospheric_pressure @daily_forecast.atmospheric_pressure
  json.humidity @daily_forecast.humidity
  json.cloudiness @daily_forecast.cloudiness
  json.midday_uv_index @daily_forecast.midday_uv_index
  json.wind_speed @daily_forecast.wind_speed
  json.wind_gust @daily_forecast.wind_gust
  json.wind_direction @daily_forecast.wind_direction
  json.rain_volume_last_hour @daily_forecast.rain_volume_last_hour
  json.snow_volume_last_hour @daily_forecast.snow_volume_last_hour
  json.weather_group_id @daily_forecast.weather_group_id
  json.weather_icon @daily_forecast.weather_icon
  json.weather_main @daily_forecast.weather_main
  json.weather_description @daily_forecast.weather_description
end