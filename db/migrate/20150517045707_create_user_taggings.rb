class CreateUserTaggings < ActiveRecord::Migration
  def change
    create_table :user_taggings do |t|
      t.integer :user_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
