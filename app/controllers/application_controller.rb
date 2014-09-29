class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :email,:occupation, :bio, :password, :password_confirmation, :facebook_url, :twitter_url, :current_activities, :ambition, :remember_me, :name, :profile_photo, assets_attributes: [:image]) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name,:occupation, :bio, :email, :password, :password_confirmation,:facebook_url, :twitter_url, :current_activities, :ambition, :current_password, :profile_photo, assets_attributes: [:image]) }
  end
  
end
