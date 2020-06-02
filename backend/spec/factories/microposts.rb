# frozen_string_literal: true

FactoryBot.define do
  factory :sunny_comment, class: Micropost do
    content { 'today is sunny.' }
    created_at { Time.now }
  end

  factory :cloudy_comment, class: Micropost do
    content { 'tomorrow is cloudy.' }
  end

  factory :rainy_comment, class: Micropost do
    content { 'day after tomorrow is rainy.' }
  end
end
