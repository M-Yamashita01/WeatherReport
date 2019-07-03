class Api::LocationOnForecastDaysController < ApplicationController
  def index
    @location_on_forecast = LocationOnForecastDay.order('updated_at DESC')
  end

  def create
    # nothing
  end

  def update
    # nothing
  end
end
