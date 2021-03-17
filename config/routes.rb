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
end
