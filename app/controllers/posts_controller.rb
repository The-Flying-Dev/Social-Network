class PostsController < ApplicationController
  #before_action :authenticate_user!

  
 
  def index 
    @posts = Post.all.paginate(page: params[:page], per_page: 5)
    #user_ids = current_user.timeline_user_ids
    #@posts = Post.includes(:user).where(user_id: user_ids) #eager loading reduces N + 1 Queries
    #  .paginate(page: params[:page], per_page: 5)
    #  .order("created_at DESC") 
  end

  def show
    @post = Post.includes(comments: [:user]).find(params[:id]) #eager loading reduces N + 1 Queries
    @moderate = (current_user == @post.user)
  end

end
