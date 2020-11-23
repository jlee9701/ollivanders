Rails.application.routes.draw do
  devise_for :users
  root to: 'wands#home'

  resources :wands do
    resources :bookings, only: [:new, :create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
