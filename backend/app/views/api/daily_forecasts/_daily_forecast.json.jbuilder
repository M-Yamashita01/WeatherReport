# frozen_string_literal: true

json.extract! daily_forecast, :id, :created_at, :updated_at
json.url daily_forecast_url(daily_forecast, format: :json)
