Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  get 'area/hokkaido' => 'area/hokkaido#index'
  get 'area/tohoku' => 'area/tohoku#index'
  get 'area/kanto' => 'area/kanto#index'
  get 'area/tokai' => 'area/tokai#index'
  get 'area/shinetsu_hokuriku' => 'area/shinetsu_hokuriku#index'
  get 'area/kinki' => 'area/kinki#index'
  get 'area/chugoku' => 'area/chugoku#index'
  get 'area/shikoku' => 'area/shikoku#index'
  get 'area/kyusyu' => 'area/kyusyu#index'
  get 'area/nanseishoto' => 'area/nanseishoto#index'

  root 'articles#index'

  namespace :api, format: 'json' do
    resources :location_on_forecast_days, only: %i[index create update]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
