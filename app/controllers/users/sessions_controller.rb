class Users::SessionsController < Devise::SessionsController


  
  def create
    params[:user].merge!(remember_me: 1)
    super
  end
  
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

end