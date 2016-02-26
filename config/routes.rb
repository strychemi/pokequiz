Rails.application.routes.draw do
  root 'users#index'

  resources :users
  resources :searches, only: [:create, :index]

  resources :profiles, except: [ :index, :new ]


  resource :session, only: [ :create, :destroy ]


  resources :results, only: [:new, :create, :show]

  resources :followings, only: [:create, :destroy]


end
