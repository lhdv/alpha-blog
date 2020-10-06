Rails.application.routes.draw do
  #
  # Pages routes
  #
  root 'pages#home'
  get 'about', to: 'pages#about'

  #
  # Articles routes
  #
  # The line below is the same as the above
  # resources :articles, only: [:show, :index, :create, :new, :edit, :update, :destroy]
  resources :articles

  #
  # Users routes
  #
  get 'signup', to: 'users#new'
  # post 'users', to: 'users#create'
  resources :users, except: [:new]

  #
  # Sessions routes
  #
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  #
  # Categories routes
  #
  resources :categories
end
