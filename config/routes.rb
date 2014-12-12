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
    resources :symtoms
    resources :current_user
    resources :users

    get "users/invitee/:token", to: "users#invitee"

    get "locales/:locale", to: "locales#show"
    get "/graph" => "graph#show"
    get "/users/:id" => "users#show"

    get "symptoms/search" => "symptoms#search"
    post "symptoms/create" => "symptoms#create"

  end

end
