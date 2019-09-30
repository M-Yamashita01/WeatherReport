require 'mysql2'
require_relative 'location_id_reader'
require_relative 'location_list'

file_path = File.expand_path('main_city.json', __dir__)

city_list = []

File.open(file_path, 'r') do |text|
  parse_text = JSON.parse(text.read)
  parse_text['city'].each { |city|
    city_list.push(city['name'])
  }
end

user_name = ENV['MYSQL_USER_DEVELOPMENT']
password = ENV['MYSQL_PASS_DEVELOPMENT']
client = Mysql2::Client.new(host: 'localhost', username: user_name, password: password)
query = 'use weather_report_development;'
results = client.query(query)

reader = LocationIdReader.new
location_list = reader.read_all_location_id
main_city_flag = 0
for location_num in 0..location_list.count - 1
  location = location_list.get
  puts location.id
  puts location.area_name
  puts location.pref_name
  puts location.location_name
  puts location.longitude
  puts location.latitude

  if city_list.include?(location.location_name)
    puts 1
    main_city_flag = 1
  else
    puts 0
    main_city_flag = 0
  end
  query = "insert into locations values(#{location.id}, \"#{location.area_name}\", \"#{location.pref_name}\", \"#{location.location_name}\", \"#{location.latitude}\", \"#{location.longitude}\", #{main_city_flag}, now(), now());"
  puts query
  client.query(query)
end

query = 'select * from locations'
results = client.query(query)
results.each do |row|
  puts row
end
