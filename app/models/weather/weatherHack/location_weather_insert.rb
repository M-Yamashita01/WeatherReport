require 'mysql2'
require_relative 'url_creator'
require_relative 'data_reader'
require_relative 'weather_collection'
require_relative 'location_weather_list'
require_relative 'location_weather'
require_relative 'forecast_day_enum'

def get_all_location_weather(date_no)
  creator = URLCreator.new
  reader = DataReader.new
  weather_collection = WeatherCollection.new(creator, reader)
  location_weather_list = weather_collection.get_all_location_weather(date_no)

  location_weather_arr = location_weather_list.get_list
  return location_weather_arr
end

user_name = ENV['MYSQL_USER_DEVELOPMENT']
password = ENV['MYSQL_PASS_DEVELOPMENT']
client = Mysql2::Client.new(host: 'localhost', username: user_name, password: password)
query = 'use weather_report_development;'
client.query(query)

# 0:今日 1:明日 2:明後日 を表す
range = 0..2
range.each do |weather_forcast_day_num|
  location_weather_arr = get_all_location_weather(weather_forcast_day_num)
  location_weather_arr.each do |location_weather|
    # 各地域の取得した天気をinsert
    query = "insert into weathers values(0, \"#{location_weather.date_label}\", \"#{location_weather.telop}\", \"#{location_weather.weather_image_url}\", #{location_weather.highest_temperature}, #{location_weather.lowest_temperature}, \"#{location_weather.weather_url}\", \"#{location_weather.public_time}\", now(), now())"
    puts query
    client.query(query)

    # その日の地域idをinsert
    query = 'select last_insert_id();'
    client.query(query)

    # 地域のidと天気idを持つテーブルへinsert
    query = "insert into location_on_forecast_days values(0, #{location_weather.location_id}, now(), \"#{location_weather.date}\", #{client.last_id}, now(), now());"
    puts query
    client.query(query)
  end
end

puts 'finish'
