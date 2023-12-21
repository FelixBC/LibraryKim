Rails.application.routes.draw do
  get '/employees/general_params', to: 'employees#general_params'
  get '/books/general_params', to: 'books#general_params'
  get '/reservations/general_params', to: 'reservations#general_params'
  get '/book_checkouts/general_params', to: 'book_checkouts#general_params'

  # Done
  resources :users, :provinces, :cities, :sectors, :employees, :books, :authors, :book_checkouts, :reservations, :events
  # Pending?
  resources :order_details
  resources :orders

  post '/login', to: 'sessions#create'
  get '/reservation_spaces', to: 'reservation_spaces#index'
  put '/reservation_spaces/:id', to: 'reservation_spaces#update'
  delete '/reservation_spaces/:id', to: 'reservation_spaces#destroy'
  get '/events', to: 'events#index'
  put '/events/:id', to: 'events#update'
  delete '/events/:id', to: 'events#destroy'
  get '/reservations', to: 'reservations#index'
  put '/reservations/:id', to: 'reservations#update'
  delete '/reservations/:id', to: 'reservations#destroy'
  get '/orders', to: 'orders#index'
  put '/orders/:id', to: 'orders#update'
  delete '/orders/:id', to: 'orders#destroy'
end
