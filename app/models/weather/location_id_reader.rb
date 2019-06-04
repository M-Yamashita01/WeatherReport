require 'json'
require_relative 'location.rb'
require_relative 'location_list.rb'
require_relative 'main_city_reader.rb'

class LocationIdReader
  # return value : LocationList
  def read_all_location_id
    parse_text = read_location_id

    location_list = LocationList.new
    reader = MainCityReader.new
    reader.read
    area = parse_text['area']
    for area_no in 0..area.count - 1
      prefs = area[area_no]['prefs']
      for pref_no in 0..prefs.count - 1
        city = prefs[pref_no]['city']
        for city_no in 0..city.count - 1
          location = Location.new
          location.area_name = area[area_no]['name']
          location.pref_name = prefs[pref_no]['name']
          location.location_name = city[city_no]['name']
          location.id = city[city_no]['id']
          location_list.add(location)
        end
      end
    end

    return location_list
  end

  def read_main_location_id
    parse_text = read_location_id

    location_list = LocationList.new
    reader = MainCityReader.new
    reader.read
    area = parse_text['area']
    for area_no in 0..area.count - 1
      prefs = area[area_no]['prefs']
      for pref_no in 0..prefs.count - 1
        city = prefs[pref_no]['city']
        for city_no in 0..city.count - 1
          city_name = city[city_no]['name']
          if reader.contain?(city_name)
            create_location_list(parse_text, area_no, pref_no, city_no, location_list)
          end
        end
      end
    end

    return location_list
  end

  def read_location_id_in_area(area_name)
    parse_text = read_location_id
    location_list = LocationList.new

    area = parse_text['area']
    for area_no in 0..area.count - 1
      if area[area_no]['name'] == area_name
        prefs = area[area_no]['prefs']
        for pref_no in 0..prefs.count - 1
          city = prefs[pref_no]['city']
          for city_no in 0..city.count - 1
            city_name = city[city_no]['name']
            create_location_list(parse_text, area_no, pref_no, city_no, location_list)
          end
        end
      end
    end

    return location_list
  end

  private

  def read_location_id
    file_path = File.expand_path('config/location_id.json', __dir__)
    parse_text = ''
    File.open(file_path, 'r') do |text|
      parse_text = JSON.parse(text.read)
    end

    return parse_text
  end

  def create_location_list(parse_text, area_no, pref_no, city_no, location_list)
    area = parse_text['area']
    prefs = area[area_no]['prefs']
    city = prefs[pref_no]['city']
    city_name = city[city_no]['name']

    location = Location.new
    location.area_name = area[area_no]['name']
    location.pref_name = prefs[pref_no]['name']
    location.location_name = city_name
    location.id = city[city_no]['id']
    location_list.add(location)
  end
end
