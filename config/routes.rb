Rails.application.routes.draw do
  root 'users#index'

  resources :users, except: [:edit]
  resources :searches, only: [:create, :index]
  resource :session, only: [ :create, :destroy ]
  resources :results, only: [:new, :index, :create, :show]
  resources :followings, only: [:create, :destroy]
  # resources :profiles, except: [ :index, :new ]

end
