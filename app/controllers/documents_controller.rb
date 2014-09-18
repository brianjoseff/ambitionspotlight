class DocumentsController < ApplicationController
  # @http_method XHR POST
  # @url /documents
  def create
    @document = current_user.documents.create(document_params)
  end
  
  def index
    @document = current_user.documents.build
  end
  
  private
  def document_params
    params.require(:document).permit(:direct_upload_url,:upload_file_name, :upload_file_size, :upload_content_type, :upload_file_path)
  end
end