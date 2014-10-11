class Document < ActiveRecord::Base
  
  # Environment-specific direct upload url verifier screens for malicious posted upload locations.
  DIRECT_UPLOAD_URL_FORMAT = %r{\Ahttps:\/\/s3\.amazonaws\.com\/myapp#{!Rails.env.production? ? "\\-#{Rails.env}" : ''}\/(?<path>uploads\/.+\/(?<filename>.+))\z}.freeze
  
  belongs_to :user
  has_attached_file :upload, s3_permissions: :public_read,
  styles: { :normal => "100%",:small => "100 x100>",:medium => "200x200>", :thumb => "50x50>", spacer: "x50" }
  
  
  
  
  #little blimp method--mostly for uploading
  #http://blog.littleblimp.com/post/53942611764/direct-uploads-to-s3-with-rails-paperclip-and
  #validates :direct_upload_url, presence: true, format: { with: DIRECT_UPLOAD_URL_FORMAT }
  
  # before_create :set_upload_attributes
  # after_create :queue_processing
  
  # Store an unescaped version of the escaped URL that Amazon returns from direct upload.
  def direct_upload_url=(escaped_url)
    write_attribute(:direct_upload_url, (CGI.unescape(escaped_url) rescue nil))
    
  end
  
  # Determines if file requires post-processing (image resizing, etc)
  def post_processing_required?
    puts "2.52.52.52.52.52.5 post_processing_required 2.52.52.52.52.52.5"
    %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png)$}.match(upload_content_type).present?
  end
  
  # Final upload processing step
  def self.transfer_and_cleanup(id)
    puts "222222 transfer_and_cleanup 222222"
    document = Document.find(id)
    #direct_upload_url_data = DIRECT_UPLOAD_URL_FORMAT.match(document.direct_upload_url)
    s3 = AWS::S3.new
    
    if document.post_processing_required?
      document.upload = URI.parse(URI.escape(document.direct_upload_url))
    else
      puts "333333333 COPY AND DELETE"
      paperclip_file_path = "documents/uploads/#{id}/original/#{direct_upload_data[:filename]}"
      s3.buckets[Rails.configuration.aws[:bucket]].objects[paperclip_file_path].copy_from(direct_upload_url[:filepath])
    end
    
    document.processed = true
    document.user_id = current_user.id
    document.save
    
    s3.buckets[Rails.configuration.aws[:bucket]].objects[direct_upload_url_data[:filepath]].delete
  end
  
  
  
  
  
  def self.copy_and_delete(paperclip_file_path, raw_source)
    s3 = AWS::S3.new #create new s3 object
    #destination = s3.buckets['ambition-dev'].objects.create(paperclip_file_path, '')
    destination = s3.buckets['ambition-dev'].objects[paperclip_file_path]
    sub_source = CGI.unescape(raw_source)
    sub_source.slice!(0) # the attached_file_file_path ends up adding an extra "/" in the beginning. We've removed this.
    puts "$%$%$%$%$ " + sub_source + "!!!!!"
    source = s3.buckets['ambition-dev'].objects[sub_source]
    tries ||= 3
    source.copy_to(destination) #copy_to is a method originating from the aws-sdk gem.
    
  rescue AWS::S3::Errors::NoSuchKey => e
    tries -= 1
    if tries > 0
      sleep(3)
      retry
    else
      source.delete #delete temp file.
    end
  end  
    # source.delete #delete temp file.
  
  
  
  
  
  private
  
  # Set attachment attributes from the direct upload
  # @note Retry logic handles S3 "eventual consistency" lag.
  
  def set_upload_attributes
    Rails.logger.info "I am rad"
    puts "111111111 set_upload_attributes 11111111"
    tries ||= 3
    #direct_upload_url_data = DIRECT_UPLOAD_URL_FORMAT.match(direct_upload_url)
    s3 = AWS::S3.new
    direct_upload_head = s3.buckets[Rails.configuration.aws[:bucket]].objects[direct_upload_url].head
    
    self.file_name          = direct_upload_data[:filename]
    self.file_type          = direct_upload_head.content_type
    self.file_size          = direct_upload_head.content_length
    self.upload_updated_at  = direct_upload_head.last_modified
  rescue AWS::S3::Errors::NoSuchKey => e
    tries -= 1
    if tries > 0
      sleep(3)
      retry
    else
      false
    end
  end
  
  # Queue file processing
  def queue_processing
    Document.delay.transfer_and_cleanup(id)
  end
end

  