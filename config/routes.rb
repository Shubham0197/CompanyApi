Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "companies" => "companies#index", as: :companies_index

  post "company" => "companies#create", as: :company_create

  resources :users, only: [:create]

  post '/login', to: 'sessions#create'

  get 'company', to: 'companies#show'

  match '*path', to: 'application#not_found', via: :all
end
