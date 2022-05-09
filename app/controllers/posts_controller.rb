class PostsController < ApplicationController
  #before_action :authenticate_user!
  #before_action :load_posts, only: [:feed]

  
   
 
  def index 
    @posts = Post.of_followed_users(current_user.following)
      .order("created_at DESC").paginate(page: params[:page], per_page: 5)
    
    #@posts = Post.includes(:user).where(user_id: user_ids) #eager loading reduces N + 1 Queries
    #  .paginate(page: params[:page], per_page: 5)
    #  .order("created_at DESC") 
  end

  def show
    @post = Post.includes(comments: [:user]).find(params[:id]) #eager loading reduces N + 1 Queries
    @moderate = (current_user == @post.user)
  end


  private 

  #def load_posts
  #  @posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  #end

end
