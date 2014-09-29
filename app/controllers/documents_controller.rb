class DocumentsController < ApplicationController
  # @http_method XHR POST
  # @url /documents
  
  # def create
  #   @document = current_user.documents.create(document_params)
  # end
  
  def create
    # if(params[:url])
    #   @document = current_user.documents.build
    #   render "new" and return
    # end

    if(params[:document][:upload_file_path])
      @document = current_user.documents.create(document_params)
      
      respond_to do |format|
        if @document.save
          #we want a destination(paperclip_file_path) and a source(raw_source)
          paperclip_file_path = "documents/uploads/#{@document.id}/original/#{params[:document][:upload_file_name]}"
          raw_source = params[:document][:upload_file_path]

          Document.copy_and_delete paperclip_file_path, raw_source #this is where we call a method to copy from temp location to where paperclip expects it to be.
          format.html { redirect_to root_url, notice: 'document was successfully created.' }
          format.json { render action: 'show', status: :created, location: @document }
        else
          format.html { render action: 'index' }
          format.json { render json: @document.errors, status: :unprocessable_entity }
        end
      end
      
    else
      @document = document.new
      render action: 'new', notice: "No file"
    end
  end
  
  
  
  def index
    @document = current_user.documents.build
  end
  
  private
  def document_params
    params.require(:document).permit(:direct_upload_url,:upload_file_name, :upload_file_size, :upload_content_type, :upload_file_path, :user_id)
  end
end