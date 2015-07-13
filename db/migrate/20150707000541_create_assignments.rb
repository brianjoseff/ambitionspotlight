class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :list_id
      t.integer :bangbang_id

      t.timestamps
    end
  end
end
