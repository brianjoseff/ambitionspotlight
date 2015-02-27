class CreateDailyAccomplishments < ActiveRecord::Migration
  def change
    create_table :daily_accomplishments do |t|
      t.text :content

      t.timestamps
    end
  end
end
