# frozen_string_literal: true

# class WeatherGroup < ApplicationRecord
class WeatherGroup < ApplicationRecord
  validates :weather_group_id, presence: true
  validates :weather_icon, presence: true
  validates :weather_main, presence: true
  validates :weather_description, presence: true
end
