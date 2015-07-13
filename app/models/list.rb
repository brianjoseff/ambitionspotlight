class List < ActiveRecord::Base
  
  has_many :assignments
  has_many :actions, through: :assignments
  belongs_to :user
  
end
