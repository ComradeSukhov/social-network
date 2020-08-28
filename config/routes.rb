Rails.application.routes.draw do
  devise_for :users

  root 'welcome_page#show'

  resource  :welcome_page, only: [:show]
  resources :users,        only: [:show]
end
