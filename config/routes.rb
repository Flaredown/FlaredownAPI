CDAI::Application.routes.draw do
  
  root "application#app"
  
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      
      devise_for :users, controllers: { registrations: "api/v1/users/registrations", sessions: "api/v1/users/sessions", confirmations: "api/v1/users/confirmations"}
      
      resources :entries
      
      resources :current_user
      resources :users
      
      get "/chart" => "chart#show"
      get "/users/:id" => "users#show"
      
    end
  end
  
end
