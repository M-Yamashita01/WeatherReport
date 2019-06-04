class Area::HokkaidoController < ApplicationController
  def index
    creator = URLCreator.new
    reader = DataReader.new
    weather_collection = WeatherCollection.new(creator, reader)
    location_weather_list = weather_collection.get_location_weather_in_area('北海道')

    @location_weather_arr = location_weather_list.get_list
    @location_weather_arr.reverse!
  end
end
