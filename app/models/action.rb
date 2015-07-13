class Action < ActiveRecord::Base
  has_many :user_bang_bangings
  has_many :users, through: :user_bang_bangings

  has_many :lists, through: :user_bang_bangings
end
