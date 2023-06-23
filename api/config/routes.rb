Rails.application.routes.draw do
  resources :owners, only: [:create]
  resources :people, only: [:create]
  get '/people', to: 'people#index'
  put '/people/:id', to: 'people#update'
  delete '/people/:id', to: 'people#destroy'
  get '/owners', to: 'owners#index'
  put '/owners/:id', to: 'owners#update'
  delete '/owners/:id', to: 'owners#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
