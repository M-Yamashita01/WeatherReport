class Api::LocationOnForecastDaysController < ApplicationController
  def index
    @location_on_forecast = LocationOnForecastDay.joins(:locations, :weathers).where('locations.main_city_flag = ?', params[:main_city_flag]).select('location_on_forecast_days.*, locations.*, weathers.*')
  end

  def create
    # nothing
  end

  def update
    # nothing
  end
end
