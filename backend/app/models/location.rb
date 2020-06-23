# frozen_string_literal: true

class Location < ApplicationRecord
  has_many :location_on_forecast_days
end
