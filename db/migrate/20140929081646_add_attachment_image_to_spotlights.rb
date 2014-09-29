class AddAttachmentImageToSpotlights < ActiveRecord::Migration
  def self.up
    change_table :spotlights do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :spotlights, :image
  end
end
