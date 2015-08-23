class DropGoalsAndGoalCategoryTables < ActiveRecord::Migration
  def up
    drop_table :goals
    drop_table :goal_categories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
