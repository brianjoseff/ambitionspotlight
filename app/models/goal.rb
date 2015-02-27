class Goal < ActiveRecord::Base
	belongs_to :goal_category
	has_many :daily_accomplishments
	
end
