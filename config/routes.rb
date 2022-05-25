Rails.application.routes.draw do 

  #gem 'notifications', '~> 1.1'
  mount Notifications::Engine => "/notifications"

  devise_for :users
  resources :comments 
  resources :posts do 
    member do 
      put 'like', to: 'posts#upvote'
      put 'dislike', to: 'posts#downvote'      
    end
  end
  resources :tags  
  
  

  
  
  
  get 'public', to: 'feed#index', as: :public
  get 'profiles/index'
  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile  
  patch ':username/edit', to: 'profiles#update', as: :update_profile

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollower_user', to: 'relationships#unfollow_user', as: :unfollow_user



  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
