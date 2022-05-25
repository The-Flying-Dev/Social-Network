class PostsController < ApplicationController
  #before_action :authenticate_user! 
   before_action :set_post, only: [:upvote, :downvote]
   before_action :post_owner, only: [:edit, :update, :destroy]
   #before_action :tag_post, only: [:index, :show, :new, :create, :edit, :update, :destroy]
 
  def index 
    if current_user     
       @posts = Post.of_followed_users(current_user.following).
       order("created_at DESC").paginate(page: params[:page], per_page: 5) 
    
    else   
      redirect_to main_app.public_path 
    end 
    #@posts = Post.includes(:user).where(user_id: user_ids) #eager loading reduces N + 1 Queries
    #  .paginate(page: params[:page], per_page: 5)
    #  .order("created_at DESC") 
  end

  def show    
      @post = Post.includes(comments: [:user]).find(params[:id]) #eager loading reduces N + 1 Queries      
      @moderate = (current_user == @post.user)     
  end


  def new 
    @post = Post.new 
  end


  def create     
    @post = current_user.posts.build(post_params)    
    if @post.save
      redirect_to main_app.post_path(@post),
                  notice: "Post was successfully created."
    else
      render :new, alert: "There was an error creating your post, try again?"
    end
  end


  def edit 
    @post = current_user.posts.find(params[:id])
  end


  def update 
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
        redirect_to main_app.post_path(@post), notice: "Post successfully updated"
    else 
      render :edit, alert: "There was an error updating your post, try again?"
    end
  end


  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to main_app.root_path, notice: "Post was successfully destroyed."   
  end



  def upvote
    #@post = Post.find(params[:id])
    @post.upvote_by current_user
    redirect_to @post #will redirect them to the same page they were on
  end
  
  def downvote
    #@post = Post.find(params[:id])
    @post.downvote_by current_user    
    redirect_to @post
  end


  
  private
 
  def set_post
    @post = Post.find(params[:id])
  end

 
  def post_owner 
    @post = Post.find(params[:id])
    unless current_user == @post.user 
      redirect_to main_app.root_path,
      alert: "This post does not belong to you!"
    end
  end

  def post_params
    params.require(:post).permit(:content, :tag_list, images: [])
  end


end
