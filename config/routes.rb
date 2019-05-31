Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  get 'area/hokkaido' => 'area/hokkaido#index'
  get 'area/tohoku' => 'area/tohoku'
  get 'area/kanto' => 'area/kanto#index'
  get 'area/tokai' => 'area/tokai#index'
  get 'area/shinetsu_hokuriku' => 'area/shinetsu_hokuriku#index'
  get 'area/kinki' => 'area/kinki#index'
  get 'area/chugoku' => 'area/chugoku#index'
  get 'area/shikoku' => 'area/shikoku#index'
  get 'area/kyusyu' => 'area/kyusyu#index'
  get 'nanseishoto' => 'area/nanseishoto#index'

  resources :articles

  resources :articles do
    resources :comments
  end

  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
