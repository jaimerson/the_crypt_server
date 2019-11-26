Rails.application.routes.draw do
  post '/users/:username/update_token', to: 'users#update_token', as: :update_token
  get '/users/:username', to: 'users#show'

  resources :users, only: %i[create] do
    collection do
      post '/authenticate', to: 'users#authenticate'
    end
  end

  resources :messages, only: %i[create]
end
