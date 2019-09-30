BASE_URL = 'http://api.openweathermap.org/data/2.5/forecast'
ID = '1858421'

require 'json'
require 'open-uri'

def get_forecast_weather_by_cityid
  api_key = ENV['OPENWEATHERMAP_API_KEY']
  response = open(BASE_URL + "?id=#{ID}&APPID=#{api_key}")
  puts JSON.pretty_generate(JSON.parse(response.read))
end

get_forecast_weather_by_cityid
