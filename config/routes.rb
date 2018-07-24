Rails.application.routes.draw do
  resources :books do
    resources :comments, only: [:index, :new, :create]
  end
  resources :users
  resources :authors, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]

  root 'welcome#home'

  post '/books/:id/add', to: 'books#add', as: 'add_book'
  post '/books/:id/remove', to: 'books#remove', as: 'remove_book'

  get '/auth/facebook/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
