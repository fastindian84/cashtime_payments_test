Rails.application.routes.draw do
  resources :app_requests
  root to: "app_requests#index"
  resources :callbacks, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
