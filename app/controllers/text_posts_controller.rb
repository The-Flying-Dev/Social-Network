class TextPostsController < ApplicationController
  before_action :authenticate_user!

   
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

  def text_post_params
    params.require(:text_post).permit(:title, :content)
  end

  
end
