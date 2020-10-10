# frozen_string_literal: true

json.extract! minutes_forecast, :id, :created_at, :updated_at
json.url minutes_forecast_url(minutes_forecast, format: :json)
