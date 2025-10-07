Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Routes for Games
  get 'games', to: 'games#index', as: 'games'
  get 'games/new', to: 'games#new', as: 'new_game'
  post 'games', to: 'games#create'
  get 'games/:id', to: 'games#show', as: 'game'
  get 'games/:id/edit', to: 'games#edit', as: 'edit_game'
  patch 'games/:id', to: 'games#update'
  put 'games/:id', to: 'games#update'
  post 'games/:id/start', to: 'games#start', as: 'start_game'

  # Defines the root path route ("/")
  # root "posts#index"
end
