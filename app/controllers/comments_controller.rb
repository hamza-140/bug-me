class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :project
  load_and_authorize_resource :comment, through: :project

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    @comment.commenter = current_user.username

    if @comment.save
      redirect_to project_path(@project), notice: "Comment created successfully"
    else
      redirect_to project_path(@project), alert: "Failed to create comment"
    end
  end

  def destroy
    if @comment.destroy
      redirect_to project_path(@project), notice: "Comment deleted successfully"
    else
      redirect_to project_path(@project), alert: "Failed to delete comment"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
