Rails.application.routes.draw do
  resources :reservations
  resources :properties do
  end
  devise_for :users
  root to: 'pages#home'
  get '/reservations/:id/cancel', to: 'reservations#cancel', as: :cancel_reservation
  get '/reservations/:id/approve', to: 'reservations#approve', as: :approve_reservation
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
