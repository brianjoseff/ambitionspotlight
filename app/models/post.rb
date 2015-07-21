class Post < ActiveRecord::Base

  has_many :taggings
  has_many :tags, through: :taggings

  has_many :bangbangings
  has_many :actions, through: :bangbangings

  has_many :assets, as: :imageable, :dependent => :destroy
  accepts_nested_attributes_for :assets
  
  belongs_to :user

end
