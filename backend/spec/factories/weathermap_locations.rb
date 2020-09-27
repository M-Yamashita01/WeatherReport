# frozen_string_literal: true

FactoryBot.define do
  factory :tokyo, class: WeathermapLocation do
    city_id { 1 }
    latitude { 139.691 }
    longitude { 35.689 }
    city_name { 'tokyo' }
    city_name_ja { '東京' }
  end
  factory :osaka, class: WeathermapLocation do
    city_id { 2 }
    latitude { 135.520 }
    longitude { 34.686 }
    city_name { 'osaka' }
    city_name_ja { '大阪' }
  end
end
