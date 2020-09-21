# frozen_string_literal: true

module Api
  # class Api::MainCityLocationsController < ApplicationController
  class MainCityLocationsController < ApplicationController
    def index
      file = File.read(Rails.public_path + \
                        'config/location/openWeatherMap/main.city.json')
      render json: file
    end
  end
end
