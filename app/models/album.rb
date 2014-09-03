class Album < ActiveRecord::Base
  
  has_many :assets, as: :imageable, :dependent => :destroy
  belongs_to :album
end
