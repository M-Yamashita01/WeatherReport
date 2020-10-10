# frozen_string_literal: true

json.extract! current_forecast, :id, :created_at, :updated_at
json.url current_forecast_url(current_forecast, format: :json)
