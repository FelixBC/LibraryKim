Rails.application.routes.draw do
  resources :authors
  resources :colors
  resources :roosters
  resources :owners, only: [:create]
  resources :people, only: [:create]
  resources :login

  get '/people', to: 'people#index'
  put '/people/:id', to: 'people#update'
  delete '/people/:id', to: 'people#destroy'
  get '/owners', to: 'owners#index'
  put '/owners/:id', to: 'owners#update'
  delete '/owners/:id', to: 'owners#destroy'
  get '/roosters', to: 'roosters#index'
  put '/roosters/:id', to: 'roosters#update'
  delete '/roosters/:id', to: 'roosters#destroy'
  get '/colors', to: 'colors#index'
  put '/colors/:id', to: 'colors#update'
  delete '/colors/:id', to: 'colors#destroy'
  get '/authors', to: 'authors#index'
  put '/authors/:id', to: 'authors#update'
  delete '/authors/:id', to: 'authors#destroy'




  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
