class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :posts, through: :taggings

  has_many :user_taggings
  has_many :users, through: :user_taggings

end
