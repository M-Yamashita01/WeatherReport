Rails.application.routes.draw do
  devise_for :users
  get 'welcome/index'
  get 'area/kanto' => 'area/kanto#index'

  resources :articles

  resources :articles do
    resources :comments
  end

  root 'articles#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
