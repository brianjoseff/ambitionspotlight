class SpotlightsController < ApplicationController


  
  
  def create
    @user = User.find(params[:user_id])
    @spotlight = @user.create_spotlight(spotlight_params)
  end
  def index
    
    @spotlights = Spotlight.all
  end
  
  private
  # def set_task
  #   @task = Task.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def spotlight_params
    params.require(:spotlight).permit( :user_id, :image)
  end
  
end
