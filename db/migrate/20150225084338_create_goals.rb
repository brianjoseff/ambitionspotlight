class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.integer :goal_category_id

      t.timestamps
    end
  end
end
