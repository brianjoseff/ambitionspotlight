class Asset < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true
  
  has_attached_file :image, :styles => { :normal => "100%",:small => "100 x100>",:medium => "200x200>", :thumb => "50x50>", :mini => "25x25>" },
                            :storage => :s3,
                            :s3_credentials => Proc.new{|a| Rails.env.production? ? a.instance.prod_s3_credentials :  a.instance.s3_credentials},                     
                            :path => "/:attachment/:id/:style/:filename"
                            
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  # :s3_credentials => "#{Rails.root}/config/s3.yml",
  #Rails.env.production? ? bucket: "readthis-prod" : bucket: "readthis-dev"
  def prod_s3_credentials
     {:bucket => "ambition-prod", :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}
  end
  def s3_credentials
      {:bucket => "ambition-dev", :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET']}
  end
end
