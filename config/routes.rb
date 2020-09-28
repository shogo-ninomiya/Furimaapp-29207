Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "items#index"
  resources :items do
    resources :comments, only: [:create]
    resources :orders, only: [:index, :create,]
    resources :likes, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  resources :comments, only: [:create]
  resources :users, only: :show
end
