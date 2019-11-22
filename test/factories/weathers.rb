FactoryBot.define do
  factory :weather do
    date_label { "MyString" }
    telop_weather { "MyString" }
    weather_image_no { "" }
    highest_temperature { "" }
    lowest_temperature { "" }
    weather_url { "MyString" }
    weather_announcement_datetime { "2019-06-10 13:09:09" }
  end
end
