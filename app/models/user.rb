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
         
  has_attached_file :profile_photo, styles: { :normal => "100%",:small => "100 x100>",:medium => "200x200>", :thumb => "50x50>", spacer: "x50" },
                                    storage: :s3,
                                    :s3_credentials => Proc.new{|a| Rails.env.production? ? a.instance.prod_s3_credentials :  a.instance.s3_credentials},
                                    :path => "/:attachment/:id/:style/:filename"


  validates_attachment_content_type :profile_photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  def prod_s3_credentials
     {:bucket => "ambition-prod", :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}
  end
  def s3_credentials
      {:bucket => "ambition-dev", :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}
  end
  
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
  has_one :spotlight
  
  accepts_nested_attributes_for :assets
  
  
  validates_presence_of :name, :email, :ambition
  
  def self.spotlit_users
    all.select do |u|
      if u.leader? && u.spotlight && u.spotlight.active?
        u
      end
    end
  end
  
  def self.leaders
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
