Rails.application.routes.draw do
  root to: 'expenses#index'

  get 'sessions/new' => 'sessions#new', as: :signin
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: :get
  match '/signout' => 'sessions#destroy', via: :delete

  resources :users

  resources :expenses, except: [:new, :edit]
end

