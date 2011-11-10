NewsFlash::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"

  post '/home/mark_as_read'

  resources :users
  resources :sessions

  root :to => 'home#index'
end
