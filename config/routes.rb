Rails.application.routes.draw do
  resources :expenses, only: [:index, :create, :update, :destroy]
end
