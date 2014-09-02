Rails.application.routes.draw do
  root to: 'expenses#index'

  get    '/signin'  => 'sessions#new', as: :signin
  delete '/signout' => 'sessions#destroy'
  match  '/auth/:provider/callback' => 'sessions#create',  via: [:get, :post]
  get    '/auth/failure'            => 'sessions#failure'

  resources :users, except: [:new, :edit, :destroy]
  get '/signup'  => 'users#new', as: :signup
  get '/profile' => 'users#edit', as: :profile

  resources :expenses, except: [:new, :edit]
end

