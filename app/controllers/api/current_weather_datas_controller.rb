class Api::CurrentWeatherDatasController < ApplicationController
  def index
    # @current_weather_data = CurrentWeatherData.joins(:weather_group, :weathermap_location).search(search_params).select('current_weather_datas.*, weather_groups.*, weathermap_locations.*')
    @current_weather_data = CurrentWeatherData.select('current_weather_datas.*')
    puts @current_weather_data
  end

  def search_params
    params.permit(:longitude_max, :longitude_min, :latitude_max, :latitude_min)
  end
end
