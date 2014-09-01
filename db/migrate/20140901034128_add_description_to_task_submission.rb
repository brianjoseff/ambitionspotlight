class AddDescriptionToTaskSubmission < ActiveRecord::Migration
  def change
    add_column :task_submissions, :description, :text
  end
end
