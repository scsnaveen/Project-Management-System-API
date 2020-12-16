class TasksController < ApplicationController
    before_action :authenticate!
  def create
	@project = Project.find(params[:project_id])
    @task = @project.tasks.create(task_params)
    render( json: UserSerializer.error("success").to_json)  
 
  end
  def index
  	project = Project.find(params[:project_id])
        project.user_id = current_user.id
        task = Task.where(project_id: params[:project_id])
         render( json: UserSerializer.error(task).to_json)  
  end
  def new 
  	 @project = Project.find(params[:project_id])
  	task = Task.new
  end
  def show
  	     task = Task.find(params[:id])
    render( json: UserSerializer.error(task).to_json) 
  end
  def destroy
    task = Task.find(params[:id])
    task.destroy
  end
  private
    def task_params
        params.permit(:name, :description,:project_id)
    end
end
