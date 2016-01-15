Rails.application.routes.draw do


  root  'users#index'
  resources :user_sessions
  resources :users
  resources :slides

  get 'login' => 'user_sessions#new', :as => :login
	post 'logout' => 'user_sessions#destroy', :as => :logout
  post 'write_html' => 'slides#write_html'
  post 'slides/download' => 'slides#download'

end
