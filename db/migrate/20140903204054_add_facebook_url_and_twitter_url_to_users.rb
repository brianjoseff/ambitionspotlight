class AddFacebookUrlAndTwitterUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_url, :string
    add_column :users, :twitter_url, :string
  end
end
