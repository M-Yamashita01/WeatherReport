# frozen_string_literal: true

json.array! @current_forecasts, partial: 'current_forecasts/current_forecast', as: :current_forecast
