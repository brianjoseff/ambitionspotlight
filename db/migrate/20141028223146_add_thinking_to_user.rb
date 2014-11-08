class AddThinkingToUser < ActiveRecord::Migration
  def change
    add_column :users, :thinking, :boolean, :default => false
  end
end
