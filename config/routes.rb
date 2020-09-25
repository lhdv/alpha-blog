Rails.application.routes.draw do
  get 'pages/home'
  get 'pages/about'
  root 'pages#home'

  get 'about', to: 'pages#about'
end
