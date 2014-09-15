class PagesController < ApplicationController
  def index
    @users = User.spotlit_users
  end
  
  def landing
  end
  
  def about
  end
end
