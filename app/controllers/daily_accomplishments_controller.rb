class DailyAccomplishmentsController < ApplicationController
  before_action :set_daily_accomplishment, only: [:show, :edit, :update, :destroy]
  before_action :find_goal_and_dailies, only: [:create, :update]

  # GET /daily_accomplishments
  # GET /daily_accomplishments.json
  def index
    @daily_accomplishments = DailyAccomplishment.all
  end

  # GET /daily_accomplishments/1
  # GET /daily_accomplishments/1.json
  def show
  end

  # GET /daily_accomplishments/new
  def new
    @daily_accomplishment = DailyAccomplishment.new
  end

  # GET /daily_accomplishments/1/edit
  def edit
  end

  # POST /daily_accomplishments
  # POST /daily_accomplishments.json
  def create
    # if remotipart_submitted?
    #   p "REMOTIPART SUBMITTED TRUE"
    # end
    @daily_accomplishment = DailyAccomplishment.new(daily_accomplishment_params)

    respond_to do |format|
      if @daily_accomplishment.save
        format.js { render 'refresh_daily_accomplishments.js.erb' }
      end
    end
  end

  # PATCH/PUT /daily_accomplishments/1
  # PATCH/PUT /daily_accomplishments/1.json
  def update
    # if remotipart_submitted?
    #   p "REMOTIPART SUBMITTED TRUE"
    # end

    respond_to do |format|
      if @daily_accomplishment.update(daily_accomplishment_params)
        format.js { render 'refresh_daily_accomplishments.js.erb' }
      else
        format.js { render 'refresh_daily_accomplishments.js.erb' }
      end
    end
  end

  # DELETE /daily_accomplishments/1
  # DELETE /daily_accomplishments/1.json
  def destroy
    @daily_accomplishment.destroy
    respond_to do |format|
      format.html { redirect_to daily_accomplishments_url, notice: 'Daily accomplishment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_daily_accomplishment
      @daily_accomplishment = DailyAccomplishment.find(params[:id])
    end

    def find_goal_and_dailies
      @goal = Goal.find(daily_accomplishment_params[:goal_id])
      unless @goal.nil?
        @daily_accomplishments = @goal.daily_accomplishments
        @da = @goal.daily_accomplishments.new
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def daily_accomplishment_params
      params.require(:daily_accomplishment).permit(:content, :image, :goal_id)
    end
end
