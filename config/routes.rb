Rails.application.routes.draw do

  root to: 'articles#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :api, format: 'json' do
    resources :location_on_forecast_days, only: %i[index]
    resources :locations, only: %i[index]
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
