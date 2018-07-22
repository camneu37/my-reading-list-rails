Rails.application.routes.draw do
  resources :books
  resources :users
  resources :authors, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]

  root 'welcome#home'

  post '/books/:id/add', to: 'books#add', as: 'add_book'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
