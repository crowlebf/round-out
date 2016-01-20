Rails.application.routes.draw do
  devise_for :users

  root to: 'welcome#index'

  resources :users, only: [:show, :edit, :update]

  resources :events do
    resources :memberships, only: [:create, :update]
  end

  resources :memberships
end
