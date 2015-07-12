class V1::BaseController < ApplicationController

	private

	def authenticate_user_from_token!
		p "HERE IN BEFORE FILTER AUTHENTICATION"
		user_email = params[:user][:email].presence
		@user = user_email && User.find_for_database_authentication(:email => user_email)
		p "USER"
		p @user
		if @user && Devise.secure_compare(@user.authentication_token, params[:user][:authentication_token])
			sign_in @user, store: false
		else
			invalid_login_attempt
		end 
	end

	def invalid_login_attempt
		warden.custom_failure!
		render :json => {:error => 'Invalid Credentials'}, :status => 401
	end
end
