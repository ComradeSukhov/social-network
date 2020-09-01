# This class is inhereted by other model' classes that has comments
#   Each one of them define its own @commentable
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment      = @commentable.comments.new(comment_params)
    @comment.user = current_user

    # Regardless of a success or failure of the save,
    #   a user must be redirected back to the wall where he tries to comment
    # In case of failure, flash will be used to transmit all neccessary
    #   information to the controller that renders comment' form

    unless @comment.save
      flash[:failed_comment_errors]  = @comment.errors.full_messages
    end

    redirect_to @commentable
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.clear_fields
    redirect_to @commentable
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
