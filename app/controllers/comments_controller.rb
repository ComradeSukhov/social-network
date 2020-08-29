class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable
    else
      flash.now[:alert] = 'Something went wrong'
      render @commentable
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end
end
