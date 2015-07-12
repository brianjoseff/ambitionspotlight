module Tokenable
  extend ActiveSupport::Concern

  def ensure_authentication_token
  	if self.authentication_token.blank?
  		self.authentication_token = generate_authentication_token
  		self.authentication_token_created_at = DateTime.now
  		self.save!
  	end
  end

  private

  def generate_authentication_token
  	loop do
	  	token = SecureRandom.hex
  		break token unless User.where(:authentication_token => token).first
  	end
  end

end