class Api::CurrentWeatherDatasController < ApplicationController
  def index
    @current_weather_data = CurrentWeatherData.joins(:weathermap_location, :weather_group).search(search_params).select('current_weather_datas.*, weathermap_location.*, weather_group.*')
  end

  def search_params
    params.permit(:longitude_max, :longitude_min, :latitude_max, :latitude_min)
  end
end
