Rails.application.routes.draw do


  root  'users#index'
  resources :user_sessions
  resources :users
  resources :slides

  get 'login' => 'user_sessions#new', :as => :login
	post 'logout' => 'user_sessions#destroy', :as => :logout
end
