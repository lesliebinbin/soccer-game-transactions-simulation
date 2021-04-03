Rails.application.routes.draw do
  if Rails.env.development?
    mount Rswag::Ui::Engine => "/api-docs"
    mount Rswag::Api::Engine => '/api-docs'
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
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
  resources :transfers do
    collection do
      get 'search'
    end
    member do
      put 'purchase'
    end
  end
end
