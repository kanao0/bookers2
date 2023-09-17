Rails.application.routes.draw do
  devise_for :users
  root :to => 'homes#top'  
  get 'home/about' => "homes#about"
  
  get 'users/edit'
  get 'books/index'
  # resources :users, only: [:show, :edit, :update]
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
