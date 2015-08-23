class DropTableDailyAccomplishments < ActiveRecord::Migration
  def up
    drop_table :daily_accomplishments
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
