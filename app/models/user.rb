class User < ActiveRecord::Base
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :history]
  def slug_candidates
      [
        :name,
        [:name, :id],
      ]
    end
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  has_many :assets, as: :imageable, :dependent => :destroy
  has_many :followships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_followships, foreign_key: "followed_id",
                                   class_name:  "Followship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_followships, source: :follower
  
  has_many :task_submissions
  has_many :tasks
  has_many :albums
  has_many :documents
  
  accepts_nested_attributes_for :assets
  
  
  validates_presence_of :name, :email, :ambition
  
  def self.spotlit_users
    all.select{|x| x.leader?}
  end
  
  def leader?
    return self.leader
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
