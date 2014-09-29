class PagesController < ApplicationController
  def index
    @users = User.spotlit_users
  end
  
  def landing
  end
  
  def admin
    @leaders = User.spotlit_users
  end
  
  def about
    @david = User.find_by_email("mrchatman1152@gmail.com")
    @brian = User.find(1)
  end
end
