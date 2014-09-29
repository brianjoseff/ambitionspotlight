class CreateSpotlights < ActiveRecord::Migration
  def change
    create_table :spotlights do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
