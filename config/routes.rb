Rails.application.routes.draw do
  root 'pages#home'
  get 'about', to: 'pages#about'

  # The line below is the same as the above
  # resources :articles, only: [:show, :index, :create, :new, :edit, :update, :destroy]
  resources :articles

  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources :users, except: [:new]
end
