Rails.application.routes.draw do
  resources :expenses, except: :new
end
