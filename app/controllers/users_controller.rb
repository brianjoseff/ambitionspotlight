class UsersController < ApplicationController

  def show
    @user = User.friendly.find(params[:id])
    if @user.leader?
      @followers = @user.followers
      @task = @user.tasks.last
    end
    
  end
  
  
  def leader_dashboard
    @user = current_user
    @tasks = @user.tasks
  end
  
  def add_photos
    @user = current_user
    @assets = @user.assets.build
  end
  
  def index
    @users = User.all
  end
  
end
