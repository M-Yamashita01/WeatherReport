FactoryBot.define do
  factory :weather_group do
    weather_group_id { 1 }
    weather_icon { "MyString" }
    weather_main { "MyString" }
    weather_description { "MyString" }
  end
end
