class CreateBangbangings < ActiveRecord::Migration
  def change
    create_table :bangbangings do |t|
      t.integer :post_id
      t.integer :bangbang_id

      t.timestamps
    end
  end
end
