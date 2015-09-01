class AddDescriptionToActions < ActiveRecord::Migration
  def change
    add_column :actions, :description, :string
  end
end
