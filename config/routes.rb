Flaredown::Application.routes.draw do

  root "application#app"

  namespace :v1, defaults: { format: 'json' } do

    devise_for :users, controllers: {
      registrations: "v1/users/registrations",
      sessions: "v1/users/sessions",
      confirmations: "v1/users/confirmations",
      invitations: "v1/users/invitations"
    }

    resources :entries
    resources :symptoms
    resources :current_user
    resources :users

    resources :symptoms
    get "symptoms/search" => "symptoms#search"

    resources :treatments
    get "treatments/search" => "treatments#search"

    get "me",                   to: "users#index"
    get "users/invitee/:token", to: "users#invitee"

    get "locales/:locale", to: "locales#show"
    get "/graph" => "graph#show"
    get "/users/:id" => "users#show"

  end

end
