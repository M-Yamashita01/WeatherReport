# frozen_string_literal: true

json.extract! hourly_forecast, :id, :created_at, :updated_at
json.url hourly_forecast_url(hourly_forecast, format: :json)
