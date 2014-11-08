class StoryElementsController < ApplicationController
  respond_to :html, :js, :json
  
  def new
    @user = current_user
    @story_element = @user.story_elements.build
  end
  
  def create
    @user = current_user
    @story_element = @user.story_elements.create(story_element_params)
  end
  
  def edit
    @user = current_user
    @story_element = StoryElement.find(params[:id])
    
    
    # respond_to do |format|
    #   format.js {@user}
    # end
  end
  
  def update
    @user = current_user
    @temp_id = params[:temp_id]
    @story_element = StoryElement.find(params[:id])
    respond_to do |format|
      if @story_element.update_attributes(story_element_params)
        format.js {}
        
      else
        format.json { render json: @story_element.errors.full_messages, status: :unprocessable_entity }
      end
    end
    
  end
  
  def delete_story_element
    @user = User.find(current_user.id)
    @story_element = StoryElement.find(params[:story_element_id])
    
  end
  
  def update_story_element
  end
  
  def add_story_element
    @user = User.find(current_user.id)
    @story_element = @user.story_elements.create(story_element_params)
    # @temp_id = params[:temp_id]
    respond_to do |format|
      if @story_element.save
        format.js {}
        format.json { render user_path(@user) }
      else
        format.json { render json: @story_element.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end
private

  def story_element_params
    params.require(:story_element).permit(:id, :user_id, :improvement, :achievement, achievement_pieces: [:a, :b, :c, :d, :e, :f, :g], improvement_pieces: [:a, :b, :c, :d, :e, :f, :g])
  end
  
end
