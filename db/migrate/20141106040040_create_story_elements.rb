class CreateStoryElements < ActiveRecord::Migration
  def change
    create_table :story_elements do |t|
      t.text :achievement
      t.text :improvement
      t.integer :user_id

      t.timestamps
    end
  end
end
