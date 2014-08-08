CDAI::Application.routes.draw do
  
  root "application#app"
  
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      
      devise_for :users, controllers: {registrations: "users/registrations"}
      
      resources :entries
      get "/chart" => "chart#show"
      get "/users/:id" => "users#show"
      
    end
  end
  
end
