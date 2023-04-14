class Api::V1::ProjectsController < ApplicationController
    before_action :authenticate_user
    before_action :set_project, only: [:show, :update, :destroy]
  
    def index
      @projects = @current_user.projects
  
      render json: @projects
    end
  
    def show
      render json: @project
    end
  
    def create
      @project = @current_user.projects.new(project_params)
      
      response.headers['Access-Control-Allow-Origin'] = 'http://127.0.0.1:5173'
      response.headers['Access-Control-Allow-Credentials'] = 'true'
      if @project.save
        render json: @project, status: :created
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @project.update(project_params)
        render json: @project
      else
        render json: @project.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @project.destroy
    end
  
    private
  
    def set_project
      @project = current_user.projects.find(params[:id])
    end
  
    def project_params
    #   params.require(:project).permit(:name)
        params.permit(:name)
    end
end
  
