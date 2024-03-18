class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show,:edit,:update,:destroy]

  def index
    @projects = current_user.projects.all
  end

  def bugs
    @projects = current_user.projects.all
  end

  def create
    @project = Project.new(project_params)
    @project.users << current_user

    if @project.save
      if params[:user_ids].present?
        user_ids = params[:user_ids].reject(&:empty?)
        user_ids.each do |user_id|
          @project.users << User.find(user_id)
        end
      end
      redirect_to @project, notice: "Success"
    else
      @users = User.all
      render :new
    end
  end


  def update
    if @project.update(project_params)
      redirect_to @project, notice: "Project updated successfully."
    else
      render :edit
    end
  end


  def destroy

  end

  def show
    @bug = Bug.new(project: @project)
    @bugs = @project.bugs.where("user_id = ? OR created_by = ?", current_user.id, current_user.id)
  end

  def new
    @project = Project.new
    @users = User.all
    @bug = Bug.new(project: @project) # Initialize a new bug for the form with the associated project
  end

  def edit
  end
  def set_project
    @project = Project.find(params[:id])
  end
  def project_params
    params.require(:project).permit(:name,:description,user_ids: [])
  end
end
