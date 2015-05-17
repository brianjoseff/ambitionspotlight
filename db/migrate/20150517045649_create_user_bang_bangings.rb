class CreateUserBangBangings < ActiveRecord::Migration
  def change
    create_table :user_bang_bangings do |t|
      t.integer :user_id
      t.integer :bangbang_id

      t.timestamps
    end
  end
end
