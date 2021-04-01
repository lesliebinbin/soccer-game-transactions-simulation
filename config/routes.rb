Rails.application.routes.draw do
  get 'players/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  resource :team, only: %i[update show]
  resources :players, only: %i[update show index]
  resources :transfers
end
