require_relative 'location_id_reader'
require_relative 'location_list'
require_relative '../db/db_access'

puts 'location insert start'

file_path = File.expand_path('../config/weatherHack/main_city.json', __dir__)

city_list = []

File.open(file_path, 'r') do |text|
  parse_text = JSON.parse(text.read)
  parse_text['city'].each { |city|
    city_list.push(city['name'])
  }
end

db_access = DBAccess.new
query = 'use weather_report_development;'
db_access.execute_query(query)

reader = LocationIdReader.new
location_list = reader.read_all_location_id
main_city_flag = 0
for location_num in 0..location_list.count - 1
  location = location_list.get

  if city_list.include?(location.location_name)
    main_city_flag = 1
  else
    main_city_flag = 0
  end

  # insertする地域情報がDBになければinsert
  query = "select location_id from locations where location_id = #{location.id};"
  results = db_access.execute_query(query)
  if results.size.zero?
    query = "insert into locations values(#{location.id}, \"#{location.area_name}\", \"#{location.pref_name}\", \"#{location.location_name}\", \"#{location.latitude}\", \"#{location.longitude}\", #{main_city_flag}, now(), now());"
    db_access.execute_query(query)
  end
end

puts 'location insert success.'
