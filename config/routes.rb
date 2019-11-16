Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:"messages#index"
<<<<<<< HEAD
  resources :users, only: [:index, :edit, :update]
  resources :groups, only: [:new, :create, :edit, :update]
=======
  resources :users, only: [:edit, :update]
>>>>>>> master
end
