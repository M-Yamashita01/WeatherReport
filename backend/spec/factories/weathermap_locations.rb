# frozen_string_literal: true

FactoryBot.define do
  factory :city, class: WeathermapLocation do
    city_id { 1 }
    latitude { 135.00 }
    longitude { 35.00 }
    city_name { 'tokyo' }
    city_name_ja { '東京' }
  end
end
