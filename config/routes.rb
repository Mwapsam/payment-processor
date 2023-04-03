Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/authorize/get_token', to: 'authorize#get_token'
    end
  end  
end
