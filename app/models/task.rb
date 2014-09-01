class Task < ActiveRecord::Base
  belongs_to :leader,    :class_name => "User", :foreign_key => :user_id
  has_many :task_submissions
end
