class RenameBangbangsToActions < ActiveRecord::Migration
  def change
    rename_table :bangbangs, :actions
  end
end
