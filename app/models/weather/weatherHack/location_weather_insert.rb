require 'mysql2'
require_relative 'url_creator'
require_relative 'data_reader'
require_relative 'weather_collection'
require_relative 'location_weather_list'
require_relative 'location_weather'
require_relative 'forecast_day_enum'
require_relative '../db/db_access'

def get_all_location_weather(date_no)
  creator = URLCreator.new
  reader = DataReader.new
  weather_collection = WeatherCollection.new(creator, reader)
  location_weather_list = weather_collection.get_all_location_weather(date_no)

  location_weather_arr = location_weather_list.get_list
  return location_weather_arr
end

puts 'location weather insert start'

db_access = DBAccess.new
query = 'use weather_report_development;'
db_access.execute_query(query)

# 0:今日 1:明日 2:明後日 を表す
range = 0..2
range.each do |weather_forcast_day_num|
  location_weather_arr = get_all_location_weather(weather_forcast_day_num)
  location_weather_arr.each do |location_weather|
    begin
      # 各地域の取得した天気をinsert
      query = "insert into weathers values(0, \"#{location_weather.date_label}\", \"#{location_weather.telop}\", \"#{location_weather.weather_image_url}\", #{location_weather.highest_temperature}, #{location_weather.lowest_temperature}, \"#{location_weather.weather_url}\", \"#{location_weather.public_time}\", now(), now())"
      db_access.execute_query(query)

      # その日の地域idをinsert
      last_insert_id = db_access.get_last_insert_id

      # 地域のidと天気idを持つテーブルへinsert
      query = "insert into location_on_forecast_days values(0, #{location_weather.location_id}, now(), \"#{location_weather.date}\", #{last_insert_id}, now(), now());"
      db_access.execute_query(query)
    rescue StandardError => e
      puts e
    end
  end
end

puts 'location weather insert success'
