class PagesController < ApplicationController
   before_filter :require_admin_login, :only => [:admin]
  def index
    # @users = User.spotlit_users
    @users = User.all

    @post = current_user.posts.new
    @posts = Post.order('created_at DESC')
  end
  
  def landing
    @landing_page = true
  end
  
  def icons
  end

  def admin
    @leaders = User.leaders
    @users = User.order('rating DESC')
  end
  
  def about
    @david = User.find_by_email("mrchatman1152@gmail.com")
    @brian = User.find(1)
  end
  
  
  def require_admin_login
    
    unless current_user.try(:leader?)
      flash[:error] = "You must be logged in as an admin to access that section" 
      # store_location
      redirect_to new_user_session_path
    end
  end





end
