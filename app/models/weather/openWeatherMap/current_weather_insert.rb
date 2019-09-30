require_relative 'current_weathers_getter'
require_relative 'current_weather_list'
require_relative 'current_weather'
require_relative 'city_id_reader'
require_relative '../db/db_access'

require 'bundler/setup'
require 'timers'

def insert_weathermap_location(db_access, current_weather)
  query = "select id from weathermap_locations where city_id = #{current_weather.city_id};"
  results = db_access.execute_query(query)

  if results.size.zero?
    db_access.insert_weathermap_location(current_weather.city_id, current_weather.latitude, current_weather.longitude, current_weather.city_name)
    results = db_access.execute_query(query)
  end

  results.each do |row|
    return row['id']
  end
end

def insert_weather_group(db_access, current_weather)
  query = "select id from weather_groups where weather_group_id = #{current_weather.weather_group_id} and weather_icon = \"#{current_weather.weather_icon}\";"
  results = db_access.execute_query(query)

  if results.size.zero?
    db_access.insert_weather_group(current_weather.weather_group_id, current_weather.weather_icon, current_weather.weather_main, current_weather.weather_description)  
    results = db_access.execute_query(query)
  end

  results.each do |row|
    return row['id']
  end
end

def insert_current_weather_data(db_access, current_weather, location_id, weather_group_id)
  db_access.insert_current_weather_data(location_id, weather_group_id, current_weather.temperature,
                                        current_weather.pressure, current_weather.humidity, current_weather.temperature_min,
                                        current_weather.temperature_max, current_weather.wind_speed, current_weather.wind_degree,
                                        current_weather.cloudiness, current_weather.rain_1h, current_weather.rain_3h,
                                        current_weather.snow_1h, current_weather.snow_3h, current_weather.sunrise, current_weather.sunset,
                                        current_weather.country_code)
end

puts 'start insert'

db_access = DBAccess.new
query = 'use weather_report_development;'
db_access.execute_query(query)

city_id_reader = CityIdReader.new
city_id_list = city_id_reader.read_city_id('JP')
current_weather_getter = CurrentWeathersGetter.new

timers = Timers::Group.new

city_id_list.each do |city|
  current_weather = CurrentWeather.new
  timers.after(1) { current_weather = current_weather_getter.get_weather(city['id']) }
  timers.wait

  puts current_weather.city_name
  location_id = insert_weathermap_location(db_access, current_weather)
  weather_group_id = insert_weather_group(db_access, current_weather)
  insert_current_weather_data(db_access, current_weather, location_id, weather_group_id)
end

puts 'success'
