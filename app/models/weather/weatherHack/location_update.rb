require_relative 'location_id_reader'
require_relative 'location_list'
require_relative '../db/db_access'

file_path = File.expand_path('../config/weatherHack/main_city.json', __dir__)

city_list = []

File.open(file_path, 'r') do |text|
  parse_text = JSON.parse(text.read)
  parse_text['city'].each { |city|
    city_list.push(city['name'])
  }
end

query = 'use weather_report_development;'
db_access = DBAccess.new
results = db_access.execute_query(query)

city_list.each do |main_city|
  query = "update locations set main_city_flag = 1 where location_name = \"#{main_city}\""
  puts query
  results = db_access.execute_query(query)
end
