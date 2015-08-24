class PostParser
	
	require 'nokogiri'
	
	def initialize(frag, current_user)
		# Setup the instance variables
		@frag = frag
		@current_user  = current_user
	end

	def parse
		noko_frag = Nokogiri::HTML(@frag)

		p "NOKO!"
		p noko_frag
	end

private
	
	def same_owner?
		@invited_owner == @current_owner
	end

	
end