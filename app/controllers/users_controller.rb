class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if @user.leader?
      @followers = @user.followers
      @task = @user.tasks.last
    end
    
  end
  
  
  def leader_dashboard
    @user = current_user
    @tasks = @user.tasks
  end
  
end
