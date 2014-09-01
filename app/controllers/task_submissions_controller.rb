class TaskSubmissionsController < ApplicationController
  before_action :set_task_submission, only: [:show, :edit, :update, :destroy]

  # GET /task_submissions
  # GET /task_submissions.json
  def index
    @task_submissions = TaskSubmission.all
  end

  # GET /task_submissions/1
  # GET /task_submissions/1.json
  def show
  end

  # GET /task_submissions/new
  def new
    @user = current_user
    @task_submission = @user.task_submissions.new
  end

  # GET /task_submissions/1/edit
  def edit
  end

  # POST /task_submissions
  # POST /task_submissions.json
  def create
    @user = current_user
    @task = Task.find(params[:task_submission][:task_id])
    @task_submission = @user.task_submissions.new(task_submission_params)
    @task_submission.task_id = @task.id
    

    respond_to do |format|
      if @task_submission.save
        format.html { redirect_to @task_submission, notice: 'Task submission was successfully created.' }
        format.json { render :show, status: :created, location: @task_submission }
      else
        format.html { render :new }
        format.json { render json: @task_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /task_submissions/1
  # PATCH/PUT /task_submissions/1.json
  def update
    respond_to do |format|
      if @task_submission.update(task_submission_params)
        format.html { redirect_to @task_submission, notice: 'Task submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @task_submission }
      else
        format.html { render :edit }
        format.json { render json: @task_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_submissions/1
  # DELETE /task_submissions/1.json
  def destroy
    @task_submission.destroy
    respond_to do |format|
      format.html { redirect_to task_submissions_url, notice: 'Task submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def reject
    @user = current_user
    @ts = TaskSubmission.find(params[:id])
    @ts.update_attribute(:status, 'rejected')
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end
  def accept
    @user = current_user
    @ts = TaskSubmission.find(params[:id])
    @ts.update_attribute(:status, 'accepted')
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end
  def pending
    @user = current_user
    @ts = TaskSubmission.find(params[:id])
    @ts.update_attribute(:status, 'pending')
    respond_to do |format|
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_submission
      @task_submission = TaskSubmission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_submission_params
      params.require(:task_submission).permit(:user_id, :task_id, :status, :description)
    end
end
