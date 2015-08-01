class FixBangBangColumnNames < ActiveRecord::Migration
  def change
    rename_column :assignments, :bangbang_id, :action_id
    rename_column :bangbangings, :bangbang_id, :action_id
    rename_column :user_bang_bangings, :bangbang_id, :action_id
  end
end
