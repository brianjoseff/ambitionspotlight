class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :populate_sidebar
  
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit( :email,:username, :occupation, :bio, :password, :password_confirmation, :facebook_url, :twitter_url, :current_activities, :ambition, :remember_me, :name, :youtube_id, :rating,:thinking, :profile_photo, assets_attributes: [:image]) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name,:username,:occupation, :bio, :email, :password, :password_confirmation,:facebook_url, :twitter_url, :current_activities, :ambition, :current_password, :youtube_id, :thinking, :rating, :profile_photo, assets_attributes: [:image]) }
  end
  
  def populate_sidebar
    @trending_list = List.first
    @trending_lists = List.last(3)
  end
end
