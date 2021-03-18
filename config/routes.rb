Rails.application.routes.draw do
  resources :tweets do 
    resources :likes
    member do
      post 'create_rt'
    end
  end
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root to: 'tweets#index'
  post 'friends/:id', to: 'friends#create', as: 'friends'
  delete'friends/:id', to: 'friends#destroy', as: 'delete_friend'
end
