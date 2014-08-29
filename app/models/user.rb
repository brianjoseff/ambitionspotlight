class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  has_many :assets, as: :imageable, :dependent => :destroy
  has_many :followships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_followships, foreign_key: "followed_id",
                                   class_name:  "Followship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_followships, source: :follower
  
  accepts_nested_attributes_for :assets
  
  def self.spotlit_users
    first(5)
  end
  
  def following?(other_user)
    followships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    followships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    followships.find_by_followed_id(other_user.id).destroy
  end
end
