Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get '/authorize/get_token', to: 'authorize#get_token'
      post "/login", to: "sessions#create"
      resources :users
      resources :transactions
      resources :fees
      resources :payment_methods
      resources :projects
    end
  end  
end
