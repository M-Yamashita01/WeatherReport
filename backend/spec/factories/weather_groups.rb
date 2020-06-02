# frozen_string_literal: true

FactoryBot.define do
  factory :weather_sunny, class: WeatherGroup do
    weather_group_id { 1 }
    weather_icon { '01d.png' }
    weather_main { 'Clear' }
    weather_description { 'clear skyd' }
  end
end
