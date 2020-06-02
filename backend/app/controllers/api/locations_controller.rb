# frozen_string_literal: true

class Api::LocationsController < ApplicationController
  def index
    @location = Location.where(main_city_flag: params[:main_city_flag])
  end
end
