class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    # @commentable was defined at controller that inherits this class
    @comment      = @commentable.comments.new(comment_params)
    @comment.user = current_user

    # In spite of saving' success or failure a user must be redirected back to
    #   the page where he tries to comment
    # In case of failure flash would be used for transfer all neccessary
    #   information to the controller, that renders comment' form

    unless @comment.save
      flash[:failed_comment_errors]  = @comment.errors.full_messages
    end

    redirect_to @commentable
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
