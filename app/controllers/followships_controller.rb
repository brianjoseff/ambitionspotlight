class FollowshipsController < ApplicationController
  before_filter :redirect_to_signup, :only => [:create,:follow]
  
  respond_to :html, :js
  
  def create
    @user = User.find(params[:followship][:followed_id])
    @followers = @user.followers
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Followship.find(params[:id]).followed
    @followers = @user.followers
    current_user.unfollow!(@user)
    respond_with @user
  end
  
  private
    def redirect_to_signup
      @user = User.find(params[:followship][:followed_id])
      unless signed_in?
        store_location
        store_user(@user)
        redirect_to new_user_registration_path, notice: "Please sign up or in."
      end
    end
    
    def store_location
      # session[:return_to] = request.url
      session[:user_return_to] = root_path
      #setting to root here because it redirects to sign up when the user tries to access /followships
      
    end
    def store_user(user)
      session[:followed_user] = user.to_param
    end
end