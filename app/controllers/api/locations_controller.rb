class Api::LocationsController < ApplicationController
  def index
    # @location = Location.order('updated_at DESC')
    @location = Location.where(main_city_flag: params[:main_city_flag])
  end
end
