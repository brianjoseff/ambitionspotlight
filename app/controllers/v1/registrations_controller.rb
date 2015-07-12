class V1::RegistrationsController < V1::BaseController
	respond_to :json
	skip_before_action :verify_authenticity_token

	# rescue_from Exception, :with => :raise_exception

	def create
		user = User.new(registration_params)
		if user.save
			user.ensure_authentication_token
			render :json => {:authentication_token => user.authentication_token, :email => user.email}, :status => 201
			return
		else
			warden.custom_failure!
			render :json => {:error => user.errors}, :status => 500
			return
		end
	end

	private

	def registration_params
		params.require(:user).permit(:email, :password, :name)
	end

	def secret_params
		params.require(:secret).permit(:token)
	end
end
