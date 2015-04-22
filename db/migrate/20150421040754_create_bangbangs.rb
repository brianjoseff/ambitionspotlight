class CreateBangbangs < ActiveRecord::Migration
  def change
    create_table :bangbangs do |t|
      t.string :title

      t.timestamps
    end
  end
end
