Rails.application.routes.draw do
  resources :reservations
  resources :properties do
  end
  devise_for :users, controllers: { registrations: "user/registrations" }
  root to: 'pages#home'
  get '/admin', to: 'pages#admin', as: :admin
  get '/reservations/:id/cancel', to: 'reservations#cancel', as: :cancel_reservation
  get '/reservations/:id/approve', to: 'reservations#approve', as: :approve_reservation
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
