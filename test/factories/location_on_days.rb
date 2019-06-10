FactoryBot.define do
  factory :location_on_day do
    location_on_day_id { 1 }
    location_id { 1 }
    date { "2019-06-10" }
    weather_id { 1 }
  end
end
