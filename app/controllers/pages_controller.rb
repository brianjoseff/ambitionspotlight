class PagesController < ApplicationController
  def index
    @users = User.spotlit_users
  end
  
  def landing
  end
  
  def about
    @david = User.find(2)
    @brian = User.find(1)
  end
end
