Rails.application.routes.draw do
  resources :books do
    resources :comments, only: [:create]
  end
  resources :users
  resources :authors, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]

  root 'welcome#home'

  post '/books/:id/add', to: 'books#add', as: 'add_book'
  post '/books/:id/remove', to: 'books#remove', as: 'remove_book'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
