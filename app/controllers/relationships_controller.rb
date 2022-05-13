class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def follow_user
    @user = User.find_by!(username: params[:username])
    if current_user.follow @user.id 
      redirect_to root_path,
      notice: "Successfully following"
    end
  end

  def unfollow_user
    @user = User.find_by!(username: params[:username])
    if current_user.unfollow @user.id 
      redirect_to root_path,
      notice: "Not following anymore"
    end
  end

end
