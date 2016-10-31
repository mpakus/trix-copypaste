Rails.application.routes.draw do
  resources :posts
  resources :uploads, only: [:create, :destroy]

  root to: 'posts#index'
end
