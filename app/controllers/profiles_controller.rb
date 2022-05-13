class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :profile_owner, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]


  def index 
    @users = User.search(params[:term])  
  end 

  def show     
    @posts = User.find_by(username: params[:username]).posts.order("created_at DESC")     
  end

  def edit        
  end  

  def update    
    if @user.update(profile_params)
      redirect_to profile_path(@user.username),
      notice: "Your profile has been successfully updated"
    else  
      render :edit, alert: "There was an error updating your profile, try again?"
    end
  end

  private 

  def set_user 
    @user = User.find_by(username: params[:username]) #user object for profile
  end

  def profile_params
    params.require(:user).permit(:bio, :term, :image)
  end

  def profile_owner
    @user = User.find_by(username: params[:username])
    unless current_user == @user 
      redirect_to root_path, 
      alert: "Unauthorized access"
    end
  end

end
