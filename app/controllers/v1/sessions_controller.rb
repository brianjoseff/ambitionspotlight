class V1::SessionsController < V1::BaseController
	respond_to :json
	skip_before_action :verify_authenticity_token

	# rescue_from Exception, :with => :raise_exception

	def create
		user = User.find_for_database_authentication(:email => sessions_params[:email])
		return invalid_login_attempt unless user

		if user.valid_password?(sessions_params[:password])
			user.ensure_authentication_token
			sign_in user, store: false
			render :json => {:authentication_token => user.authentication_token, :email => user.email}, :status => 200
			return
		end
		invalid_login_attempt
	end

	def destroy
		user_email = sessions_params[:email].presence
		user = user_email && User.find_for_database_authentication(:email => sessions_params[:email])

		if user && Devise.secure_compare(user.authentication_token, sessions_params[:authentication_token])
			user.update_attributes!(:authentication_token => nil)
			sign_out user
			render :json => {:email => user.email}, :status => 200	
			return
		end
		invalid_login_attempt
	end

	private

	def sessions_params
		params.require(:user).permit(:email, :password, :authentication_token)
	end
end
