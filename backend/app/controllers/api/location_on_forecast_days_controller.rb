# frozen_string_literal: true

class Api::LocationOnForecastDaysController < ApplicationController
  def index
    @location_on_forecast = LocationOnForecastDay.joins(:location, :weather).search(search_params).select('location_on_forecast_days.*, locations.*, weathers.*')
  end

  def search_params
    params.permit(:date, :main_city_flag, :longitude_max, :longitude_min, :latitude_max, :latitude_min)
  end

  def create
    # nothing
  end

  def update
    # nothing
  end
end
