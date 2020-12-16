class AttachmentsController < ApplicationController
       # before_action :authenticate!
  def index
  	  	attachments = Attachment.where(project_id: params[:project_id])
        render( json: UserSerializer.error(attachments).to_json)  
  end

  def new
    project = Project.find(params[:project_id])
  	attachment = Attachment.new
  end

  def create 
   project = Project.find(params[:project_id])
    attachment = Attachment.new(attachment_params)

      image = Paperclip.io_adapters.for(params[:attachment])
      image.original_filename = "file1.jpg"
      attachment.attachment = image
      if attachment.save
        render( json: UserSerializer.error("success").to_json)  
      else
        render( json: UserSerializer.error(attachment.errors.full_messages).to_json)
      end
  end
  
  def show
  	    @project = Project.find(params[:project_id])
        @attachments = Attachment.where(project_id: params[:project_id])
  end

  def destroy
  	 attachment = Attachment.find(params[:id])
     attachment.destroy
  end
 
  private
    def attachment_params
        params.permit(:project_id)
    end
end