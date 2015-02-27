class AddGoalIdToDailyAccomplishment < ActiveRecord::Migration
  def change
    add_column :daily_accomplishments, :goal_id, :integer
  end
end
