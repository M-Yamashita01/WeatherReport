Rails.application.routes.draw do

  #devise_for :users
  root to: 'articles#index'

  #devise_for :users, controllers: {
  #  registrations: 'users/registrations',
  #  sessions: 'users/sessions'
  #}

  #devise_scope :user do
  #  get 'sign_in', to: 'users/sessions#new'
  #  get 'sign_out', to: 'users/sessions#destroy'
  #end

  namespace :api, format: 'json' do
    resources :location_on_forecast_days, only: %i[index]
    resources :locations, only: %i[index]
  end

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations'
    }
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
