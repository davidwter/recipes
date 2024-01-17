Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'recipes', to: 'recipes#index'
  get 'recipes/search', to: 'recipes#search'
  get 'recipes/:id', to: 'recipes#show'
  get 'ingredients', to: 'ingredients#index'

  # Defines the root path route ("/")
  # root "posts#index"
end
