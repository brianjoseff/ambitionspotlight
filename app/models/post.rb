class Post < ActiveRecord::Base

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :bangbangings
  has_many :actions, through: :bangbangings

end
