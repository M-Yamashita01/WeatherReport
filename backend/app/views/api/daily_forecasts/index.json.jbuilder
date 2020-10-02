#json.array! @daily_forecasts, partial: "daily_forecasts/daily_forecast", as: :daily_forecast

# if @daily_forecast.nil?
#   render json: { error: 'not found' }, status: 422
# else 
  json.set! :daily_forecast do
    json.extract! @daily_forecast, :city_name
  end
# end
