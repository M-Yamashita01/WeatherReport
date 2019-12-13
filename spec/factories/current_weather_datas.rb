FactoryBot.define do
  factory :current_weather_datum do
    acquired_datetime { "2019-09-17 22:54:15" }
    temperature { 1.5 }
    pressure { 1.5 }
    humidity { 1 }
    temperature_min { 1.5 }
    temperature_max { 1.5 }
    wind_speed { 1.5 }
    wind_degree { 1.5 }
    cloudiness { 1 }
    rain_1h { 1.5 }
    rain_3h { 1.5 }
    snow_1h { 1.5 }
    snow_3h { 1.5 }
    country_code { "MyString" }
  end
end
