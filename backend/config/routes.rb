Rails.application.routes.draw do
  namespace :api, format: 'json' do
    resources :location_on_forecast_days, only: %i[index]
    resources :current_weather_datas, only: %i[index]
    resources :locations, only: %i[index]
    resources :main_city_locations, only: %i[index]
    resources :microposts, only: %i[index create destroy]
    resources :current_forecasts, only: %i[index]
    resources :minutes_forecasts, only: %i[index]
    resources :hourly_forecasts, only: %i[index]
    resources :daily_forecasts, only: %i[index]
  end

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end
end
