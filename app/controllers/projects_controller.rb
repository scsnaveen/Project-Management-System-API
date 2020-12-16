class ProjectsController < ApplicationController
	before_action :authenticate!
  def index
    projects = Project.all
     render( json: UserSerializer.error(projects).to_json)  
  end
 def show
 	
 	project = Project.find(params[:id])
    render( json: UserSerializer.error(project).to_json)  
 end
  #  def new
  #   @project = Project.new()
  # end
  def create
  	puts params[:title].inspect
  	@project = Project.new(project_params)
    @project.user_id = current_user.id
    # @project.project_type = params[:project_type]
    # puts @project.inspect
   
      if @project.save
      	render( json: UserSerializer.error("success").to_json)  

      else
       render(json: UserSerializer.error(@project.error.details))
      end
  end
  def destroy
  	@project = Project.find(params[:id])
  	@project.destroy
  end
  def project_params
      params.require(:Project).permit(:title, :text,:project_type)
    end
end