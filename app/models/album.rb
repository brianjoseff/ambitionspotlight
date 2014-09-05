class Album < ActiveRecord::Base
  
  has_many :assets, as: :imageable, :dependent => :destroy
  belongs_to :user
  
  accepts_nested_attributes_for :assets
end
