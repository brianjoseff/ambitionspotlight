class CreateTaskSubmissions < ActiveRecord::Migration
  def change
    create_table :task_submissions do |t|
      t.integer :user_id
      t.integer :task_id
      t.string :status

      t.timestamps
    end
  end
end
