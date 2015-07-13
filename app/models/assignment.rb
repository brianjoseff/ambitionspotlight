class Assignment < ActiveRecord::Base
  belongs_to :action
  belongs_to :list
end
