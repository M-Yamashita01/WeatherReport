require 'json'
require_relative 'location.rb'
require_relative 'location_list.rb'

class LocationIdReader
  # return value : LocationList
  def read
    file_path = File.expand_path('../../config/locationId.json', __FILE__)
    File.open(file_path, 'r') do |text|
      @parse_text = JSON.parse(text.read)
    end

    location_list = LocationList.new
    area = @parse_text['area']
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
end
