class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :text
    add_column :users, :occupation, :string
  end
end
