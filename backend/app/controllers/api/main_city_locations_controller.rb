# frozen_string_literal: true

class Api::MainCityLocationsController < ApplicationController
  def index
    file = File.read(Rails.public_path + 'config/location/openWeatherMap/main.city.json')
    render json: file
  end
end
