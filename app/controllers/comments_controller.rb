class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment      = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable
    else
      flash[:alert]  = @comment.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to @commentable
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
