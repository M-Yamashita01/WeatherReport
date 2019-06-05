require_relative '../common/weather_collection'

class Area::KyusyuController < ApplicationController
  def index
    @location_weather_arr = WeatherCollection.get_weather_collection_in_area('九州')
  end
end
