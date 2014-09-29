class PagesController < ApplicationController
  def index
    @users = User.spotlit_users
  end
  
  def landing
  end
  
  def about
    @david = User.findby_email("mrchatman1152@gmail.com")
    @brian = User.find(1)
  end
end
