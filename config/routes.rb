Rails.application.routes.draw do
  resources :users


  resources :profiles, except: [ :index, :new ]


  resource :session, only: [ :create, :destroy ]


  resources :results, only: [:new, :create, :show]


end
