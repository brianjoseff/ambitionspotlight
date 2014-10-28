class UsersController < ApplicationController

  def show
    
    @user = User.friendly.find(params[:id])
    if @user.leader?
      
      @task = @user.tasks.last
    end
    @followers = @user.followers
    @activity = @user.activities.build
    
  end
  
  def update
  end
  
  def admin_edit
    @user = User.friendly.find(params[:id])
  end
  
  def admin_update
    @user = User.friendly.find(params[:id])
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def delete_activity
    @user = User.find(current_user.id)
    @activity = Activity.find(params[:activity_id])
    
  end
  
  def add_activity
    @user = User.find(current_user.id)
    @activity = @user.activities.create(activity_params)
    @temp_id = params[:temp_id]
    respond_to do |format|
      if @activity.save
        format.js {}
        format.json { render :add_activity }
      else
        format.json { render json: @activity.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
  
  
  # def add_ambition
  #   @user = User.find(current_user.id)
  #   @activity = @user.activities.create(activity_params)
  #   
  #   respond_to do |format|
  #     if @activity.save
  #       format.js {}
  #       format.json { render :add_activity }
  #     else
  #       format.json { render json: @activity.errors.full_messages, status: :unprocessable_entity }
  #     end
  #   end
  # end
  
  def edit_ambition
    @user = current_user
    respond_to do |format|
      format.js {@user}
    end
  end
  
  def update_ambition
    @user = User.find(current_user.id)
    
    respond_to do |format|
      if @user.update(user_params)
        format.js {}
        format.json { render @user }
      else
        format.json { render json: @activity.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
  
  
  def destroy
    @user = User.friendly.find(params[:id])
    @user.destroy
    render @user
  end
  
  def edit_bio
    @user = current_user
    respond_to do |format|
      format.js {@user}
    end
  end
  
  def update_rating
    @user = User.find(user_params[:id])
    @user.rating = user_params[:rating]
    if @user.ambition.nil?
      @user.ambition = '.'
    end
    @user.save!
    respond_to do |format|
      if @user.save
        format.html { render @user}
      else
        format.html { render @user}
      end
    end
  end
  
  def update_youtube
    @user = User.find(user_params[:id])
    @user.youtube_id = user_params[:youtube_id]
    if @user.ambition.nil?
      @user.ambition = '.'
    end
    @user.save!
    respond_to do |format|
      if @user.save
        format.html { render @user}
      else
        format.html { render @user}
      end
    end
  end
  
  def update_soundcloud
    @user = User.find(user_params[:id])
    @user.soundcloud_id = user_params[:soundcloud_id]
    if @user.ambition.nil?
      @user.ambition = '.'
    end
    @user.save!
    respond_to do |format|
      if @user.save
        format.html { render @user}
      else
        format.html { render @user}
      end
    end
  end
  
  def update_bio
    @user = User.find(current_user.id)

    respond_to do |format|
      # puts "************" + params[:ad_lib]
      
      if params[:ad_lib] == 'ad_lib'
        # puts "%%%%%%%%%%%" + params[:ad_lib]
        # bio_params
        bio = "I come from "+ bio_params[:a] +". I believe in "+ bio_params[:b]+", "+bio_params[:c]+", and " +bio_params[:d]+". People know me for "+ bio_params[:e]+". I am committed to "+bio_params[:f]+". I hope to "+bio_params[:g]+"."
        # puts "!!!!!!!!!" + bio
        # +", ______, and ______. People know me for  ______. I am committed to ______. I hope to _______________."
        if @user.update(bio: bio)
          format.js {}
          format.json { render @user }
        else
          format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
        end
      else
        # puts "xzxzxzxzxzxzxzxzxzx"
        # bio = user_params[:bio].gsub! /\n /, "\n\n"
        bio = user_params[:bio]
        # puts bio
        if @user.update(bio: bio)
          format.js {}
          format.json { render @user }
        else
          format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
        end
      end
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
    @users = User.order('rating DESC')
  end


private
  def activity_params
    params.require(:activity).permit(:user_id, :title)
  end
  def user_params
    params.require(:user).permit(:id, :ambition, :name, :bio,:youtube_id,:soundcloud_id, :rating, :profile_photo, bio_pieces: [:a, :b, :c, :d, :e, :f, :g])
  end
  def bio_params
    params.require(:bio_pieces).permit(:a, :b,:c, :d, :e, :f, :g)
  end
end
