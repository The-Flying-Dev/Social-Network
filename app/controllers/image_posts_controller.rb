class ImagePostsController < ApplicationController
  before_action :authenticate_user!

  
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

  def image_post_params
    params.require(:image_post).permit(:title, :content, :url)
  end

end
