class AddAttachmentImageToDailyAccomplishments < ActiveRecord::Migration
  def self.up
    change_table :daily_accomplishments do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :daily_accomplishments, :image
  end
end
