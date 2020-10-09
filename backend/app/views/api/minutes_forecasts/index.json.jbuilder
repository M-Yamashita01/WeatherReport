# frozen_string_literal: true

json.array! @minutes_forecasts, partial: 'minutes_forecasts/minutes_forecast', as: :minutes_forecast
