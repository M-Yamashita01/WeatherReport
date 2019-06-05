class WeatherCollection
  class << self
    def get_weather_collection_in_area(area_name)
      creator = URLCreator.new
      reader = DataReader.new
      weather_collection = WeatherCollection.new(creator, reader)
      location_weather_list = weather_collection.get_location_weather_in_area(area_name)

      location_weather_arr = location_weather_list.get_list
      location_weather_arr.reverse!
      return location_weather_arr
    end
  end
end
