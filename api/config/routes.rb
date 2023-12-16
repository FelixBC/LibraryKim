Rails.application.routes.draw do
  resources :orders
  resources :reservations
  resources :events
  resources :reservation_spaces
  resources :supplier_categories
  resources :supplier_types
  resources :phones
  resources :genders
  resources :provinces
  resources :cities
  resources :countries
  resources :sectors
  resources :contacts
  resources :emails
  resources :roles
  resources :authors
  resources :users

  get '/authors', to: 'authors#index'
  put '/authors/:id', to: 'authors#update'
  delete '/authors/:id', to: 'authors#destroy'
  get '/users', to: 'users#index'
  put '/users/:id', to: 'users#update'
  delete '/users/:id', to: 'users#destroy'
  get '/emails', to: 'emails#index'
  put '/emails/:id', to: 'emails#update'
  delete '/emails/:id', to: 'emails#destroy'
  get '/contacts', to: 'contacts#index'
  put '/contacts/:id', to: 'contacts#update'
  delete '/contacts/:id', to: 'contacts#destroy'
  get '/roles', to: 'roles#index'
  put '/roles/:id', to: 'roles#update'
  delete '/roles/:id', to: 'roles#destroy'
  get '/supplier_types', to: 'supplier_types#index'
  put '/supplier_types/:id', to: 'supplier_types#update'
  delete '/supplier_types/:id', to: 'supplier_types#destroy'
  get '/supplier_categories', to: 'supplier_categories#index'
  put '/supplier_categories/:id', to: 'supplier_categories#update'
  delete '/supplier_categories/:id', to: 'supplier_categories#destroy'
  get '/reservation_spaces', to: 'reservation_spaces#index'
  put '/reservation_spaces/:id', to: 'reservation_spaces#update'
  delete '/reservation_spaces/:id', to: 'reservation_spaces#destroy'
  get '/events', to: 'events#index'
  put '/events/:id', to: 'events#update'
  delete '/events/:id', to: 'events#destroy'
  get '/reservations', to: 'reservations#index'
  put '/reservations/:id', to: 'reservations#update'
  delete '/reservations/:id', to: 'reservations#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
