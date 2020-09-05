class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def show
    # Render a parent comment if such is given
    #   otherwise render direct comments of the post

    comment_parameters = if params[:parent_comment]
                           "comments.id = #{ params[:parent_comment] }"
                         else
                           'comments.parent_id IS NULL'
                         end

    @comments = @post.comments
                     .where(comment_parameters)
                     .order(:created_at)
  end

  def create
    @post = Post.new(post_params)

    # Regardless of a success or failure of the save,
    #   a user must be redirected back to the wall where he tries to post
    # In case of failure, flash will be used to transmit all neccessary
    #   information to the controller that renders post' form

    unless @post.save
      flash[:failed_post]        = @post
      flash[:failed_post_errors] = @post.errors.full_messages
    end

    redirect_back(fallback_location: root_path)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :wall_id, :author_id)
    end
end
