class AddUploadFilePathToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :upload_file_path, :string
  end
end
