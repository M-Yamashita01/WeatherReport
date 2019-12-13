FactoryBot.define do
  factory :weathermap_location do
    city_id { 1 }
    latitude { 1.5 }
    longitude { 1.5 }
    city_name { "MyString" }
  end
end
