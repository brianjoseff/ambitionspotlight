class Users::RegistrationsController < Devise::RegistrationsController


  
  
  def new
    # Override Devise default behaviour and create a profile as well
    build_resource({})
    resource.assets.build
    respond_with self.resource
  end

  def edit

    resource.assets.build
    puts params
    @user = User.friendly.find(params[:format])
    
  end
  
  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
  def after_sign_up_path_for(resource)
    user_path(current_user)
  end
  def after_update_path_for(resource)
    user_path(current_user)
  end

  private

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
  def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

  
  
end