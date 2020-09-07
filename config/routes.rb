Rails.application.routes.draw do
  devise_for :users

  root 'welcome_pages#show'

  resource  :welcome_page, only: [:show]
  resources :users,        only: [:index, :show]

  resources :posts, only: [:show, :create] do
    resources :comments, only: [:create, :destroy], module: :posts
  end
end
