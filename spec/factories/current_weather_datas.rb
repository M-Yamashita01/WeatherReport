FactoryBot.define do
  factory :current_weather_sample, class: CurrentWeatherDatas do
    acquired_datetime { Time.now }
    weathermap_location { 1 }
    weather_group { 1 }
    temperature { 289.92 }
    pressure { 1009 }
    humidity { 92 }
    temperature_min { 288.71 }
    temperature_max { 290.93 }
    wind_speed { 0.47 }
    wind_degree { 107.538 }
    cloudiness { 2 }
    country_code { 'JP '}
  end
end