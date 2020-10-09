# frozen_string_literal: true

FactoryBot.define do
  factory :forecast, class: Forecast do
    created_at { Time.now }

    trait :current do
      forecast_type { 'current' }
      forecast_datetime { DateTime.now }
    end

    trait :minutely do
      forecast_type { 'minutely' }
      forecast_datetime { DateTime.now }
    end

    trait :hourly do
      forecast_type { 'hourly' }
      forecast_datetime { DateTime.now }
    end

    trait :daily do
      forecast_type { 'daily' }
      forecast_datetime { DateTime.now }
    end
  end
end
