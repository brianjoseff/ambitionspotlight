class TaskSubmission < ActiveRecord::Base
  after_initialize :set_to_pending
  after_update :status_change
  validates :user_id, presence: true
  validates :task_id, presence: true
  
  belongs_to :user
  belongs_to :task
  has_many :assets, as: :imageable, :dependent => :destroy
  
  def set_to_pending
    self.status ||= 'pending'
  end
  
  def status_change
    if self.status == 'rejected'
      # send notification to user
    elsif self.status == 'accepted'
      # create followship
      self.user.follow!(self.task.leader)
      # notify user
    end
  end
end
