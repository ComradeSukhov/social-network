class Posts::CommentsController < CommentsController
  before_action :set_commentable

  private
    # Define an object to which a comment is being written
    def set_commentable
      @commentable = Post.find(params[:post_id])
    end
end
