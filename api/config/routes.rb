Rails.application.routes.draw do
  resources :people, only: [:create]
  get '/people', to: 'people#index'
  put '/people/:id', to: 'people#update'
  delete '/people/:id', to: 'people#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
