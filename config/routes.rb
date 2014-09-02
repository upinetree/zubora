Rails.application.routes.draw do
  root to: 'expenses#index'

  get 'signin' => 'sessions#new', as: :signin
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: :get
  match '/signout' => 'sessions#destroy', via: :delete

  resources :users, except: [:new, :edit, :destroy]
  get '/signup'  => 'users#new', as: :signup
  get '/profile' => 'users#edit', as: :profile

  resources :expenses, except: [:new, :edit]
end

