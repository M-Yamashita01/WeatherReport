Rails.application.routes.draw do
  root to: 'articles#index'

  namespace :api, format: 'json' do
    resources :location_on_forecast_days, only: %i[index]
    resources :current_weather_datas, only: %i[index]
    resources :locations, only: %i[index]
  end

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end

  # get '*path', to: 'articles#redirect_to_root'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
