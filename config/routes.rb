Rails.application.routes.draw do
  get 'sessions/new' => 'sessions#new', as: :signin
  match '/auth/:provider/callback' => 'sessions#create', via: [:get, :post]
  match '/auth/failure' => 'sessions#failure', via: :get
  match '/signout' => 'sessions#destroy', via: :get

  resources :users, only: [:index, :new]

  resources :expenses, except: [:new, :edit]
end
