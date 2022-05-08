class TextPostsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_text_post, only: [:show :edit, :update, :destroy]
  #before_action :text_post_owner, only: [:edit, :update, :destroy]

   
  def new 
    @text_post = TextPost.new 
  end

  def create 
    @text_post = current_user.text_posts.build(text_post_params)

    if @text_post.save
      redirect_to post_path(@text_post),
                  notice: "Post was successfully created."
    else
      render :new, alert: "There was an error creating your post, try again?"
    end
  end


  def edit 
    @text_post = current_user.text_posts.find(params[:id])
  end

  def update 
    @text_post = current_user.text_posts.find(params[:id])
    if @text_post.update(text_post_params)
        redirect_to post_path(@text_post), notice: "Post successfully updated"
    else 
      render :edit, alert: "There was an error updating your post, try again?"
    end
  end

  def destroy
    @text_post = current_user.text_posts.find(params[:id])
    @text_post.destroy
    redirect_to root_path, notice: "Post was successfully destroyed."   
  end


  private 

  def set_text_post
    @text_post = TextPost.find(params[:id])
  end
  #def text_post_owner 
    #unless current_user == @text_post.user 
      #redirect_to root_path
      #alert: "This post does not belong to you!"
    #end
  #end

  def text_post_params
    params.require(:text_post).permit(:title, :content)
  end

  
end
