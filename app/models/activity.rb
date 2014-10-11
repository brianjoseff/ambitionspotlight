class Activity < ActiveRecord::Base
  belongs_to :user
  
  
  def deactivate!
    self.active = false
    self.save!
  end
end
