Rails.application.routes.draw do
  
  #get 'feed/index'
  #get 'feed/index'
  devise_for :users
  resources :comments
  resources :image_posts
  resources :text_posts
  resources :posts
  get ':posts', to: 'posts#index'
  
  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile  
  patch ':username/edit', to: 'profiles#update', as: :update_profile

  post ':username/follow_user', to: 'relationships#follow_user', as: :follow_user
  post ':username/unfollower_user', to: 'relationships#unfollow_user', as: :unfollow_user



  root 'feed#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
