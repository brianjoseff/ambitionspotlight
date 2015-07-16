class Action < ActiveRecord::Base
  has_many :user_bang_bangings
  has_many :users, through: :user_bang_bangings

  has_many :assignments
  has_many :lists, through: :assignments
end
