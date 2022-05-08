Rails.application.routes.draw do
  
  
  devise_for :users
  resources :comments
  resources :image_posts
  resources :text_posts
  resources :posts
  
  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile  
  patch ':username/edit', to: 'profiles#update', as: :update_profile



  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
