Rails.application.routes.draw do
  devise_for :users

  root to: 'welcome#index'

  resources :users, only: [:show, :edit, :update]

  resources :events do
    resources :memberships, only: [:create, :update, :destroy]
  end

  resources :events do
    resources :comments
  end

  resources :memberships

  namespace :api do
    namespace :v1 do
      resources :comments do
        collection do
          post 'create'
          post 'destroy'
        end
      end
    end
  end

end
