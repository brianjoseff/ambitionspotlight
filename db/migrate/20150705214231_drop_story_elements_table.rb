class DropStoryElementsTable < ActiveRecord::Migration
  def change
    drop_table :story_elements
  end
end
