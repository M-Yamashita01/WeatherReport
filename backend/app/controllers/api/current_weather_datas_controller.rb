# frozen_string_literal: true

module Api
  # class Api::CurrentWeatherDatasController < ApplicationController
  class CurrentWeatherDatasController < ApplicationController
    def index
      @current_weather_data = CurrentWeatherDatas.joins(:weathermap_location, :weather_group).search(search_params).select('current_weather_datas.*, weathermap_locations.*, weather_groups.*')
    end

    def search_params
      params.permit(:longitude_max, :longitude_min, :latitude_max, :latitude_min)
    end
  end
end
