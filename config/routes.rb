Rails.application.routes.draw do
  resources :books
  resources :users
  resources :authors, only: [:index, :show]
  resources :sessions, only: [:new, :create, :destroy]

  root 'welcome#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
