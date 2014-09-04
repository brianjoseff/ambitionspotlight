class AddAmbitionAndCurrentActivitiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :ambition, :text
    add_column :users, :current_activities, :text
  end
end
