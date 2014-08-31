Rails.application.routes.draw do
  root to: 'expenses#index'

  get 'sessions/new' => 'sessions#new', as: :signin
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: :get
  match '/signout' => 'sessions#destroy', via: :delete

  resources :users, except: [:edit, :destroy]
  get '/profile' => 'users#edit', as: :profile, via: :get

  resources :expenses, except: [:new, :edit]
end

