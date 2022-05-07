class ImagePostsController < ApplicationController
  before_action :authenticate_user!
  #before_action :image_post_owner, only: [:edit, :update, :destroy]

  
  def new 
    @image_post = ImagePost.new 
  end

  def create 
    @image_post = current_user.image_posts.build(image_post_params)

    if @image_post.save
      redirect_to post_path(@image_post),
                  notice: "Image was successfully posted."
    else
      render :new, alert: "There was an error creating your post, try again?"
    end
  end

  def edit 
    @image_post = current_user.image_posts.find(params[:id])
  end

  def update 
    @image_post = current_user.image_posts.find(params[:id])
    if @image_post.update(image_post_params)
        redirect_to post_path(@image_post), notice: "Post successfully updated"
    else 
      render :edit, alert: "There was an error updating your post, try again?"
    end
  end

  def destroy
    @image_post = current_user.image_posts.find(params[:id])
    @image_post.destroy
    redirect_to root_path, notice: "Post was successfully destroyed."   
  end


  private

  #def image_post_owner 
    #unless current_user == @image_post.user 
      #redirect_to root_path
      #alert: "This post does not belong to you!"
    #end
  #end

  def image_post_params
    params.require(:image_post).permit(:title, :content, :url)
  end

end
