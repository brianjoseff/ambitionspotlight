# Load the Rails application.
require File.expand_path('../application', __FILE__)

ActionMailer::Base.register_template_extension('haml')

# Initialize the Rails application.
Rails.application.initialize!
