Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get '/authorize/get_token', to: 'authorize#get_token'
      resources :api_keys, path: 'api-keys', only: %i[index create destroy]
    end
  end  
end
