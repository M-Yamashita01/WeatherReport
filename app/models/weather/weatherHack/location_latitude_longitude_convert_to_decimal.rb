require 'json'
require_relative 'location_information'
require_relative 'location_list'

def read_location_id
  file_path = File.expand_path('location_id.json', __dir__)
  parse_text = ''
  File.open(file_path, 'r') do |text|
    parse_text = JSON.parse(text.read)
  end

  return parse_text
end

def read_all_location_id
  parse_text = read_location_id

  location_list = LocationList.new
  area = parse_text['area']
  for area_no in 0..area.count - 1
    prefs = area[area_no]['prefs']
    for pref_no in 0..prefs.count - 1
      city = prefs[pref_no]['city']
      for city_no in 0..city.count - 1

          puts area[area_no]['name']
          puts prefs[pref_no]['name']
          puts city[city_no]['name']
          puts city[city_no]['longitude']
          puts city[city_no]['latitude']

          longitude = city[city_no]['longitude']
          latitude = city[city_no]['latitude']
          longitude_decimal = convert_latitude_longitude_to_decimal(longitude)
          latitude_decimal = convert_latitude_longitude_to_decimal(latitude)

          longitude_decimal_truncation = longitude_decimal.floor(4).to_s
          latitude_decimal_truncation = latitude_decimal.floor(4).to_s

          puts longitude_decimal_truncation
          puts latitude_decimal_truncation

          city[city_no]['longitude'] = longitude_decimal_truncation
          city[city_no]['latitude'] = latitude_decimal_truncation
      end
    end
  end

  # 更新したjsonファイルを保存
  save_json(parse_text)

  return location_list
end

def convert_latitude_longitude_to_decimal(latitude_longitude)
  array = latitude_longitude.split('.')
  puts degree = array[0].to_f
  puts min = array[1].slice(0, 2).to_f
  puts sec = array[1].slice(2, 2).to_f

  return degree + (min * 60 + sec) / 3600
end

def save_json(parse_text)
  File.open('location_id_new.json', 'w') do |text|
    JSON.dump(parse_text, text)
  end
end

read_all_location_id
