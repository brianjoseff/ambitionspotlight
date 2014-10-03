class SpotlightsController < ApplicationController


  
  
  def create
    @user = User.find(params[:user_id])
    @spotlight = @user.create_spotlight(spotlight_params)
    respond_to do |format|
      if @spotlight
        format.html { redirect_to admin_path, notice: 'Spotlight created.' }
        # format.json { render :show, status: :created, location: @spotlight }
      else
        format.html { render admin_path }
        # format.json { render json: @spotlight.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    
    @spotlights = Spotlight.all
  end
  
  def update
    @user = User.find(params[:user_id])
    @spotlight = @user.spotlight.update_attributes(spotlight_params)
    if successfully_updated
      redirect_to admin_path
    else
      render admin_path
    end
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
