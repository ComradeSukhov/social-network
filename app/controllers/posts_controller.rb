class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show]

  def show
    # Render a parent comment if such is given
    #   otherwise render direct comments of the post
    if params[:parent_comment]
      @comments = @post.comments.where(id: params[:parent_comment])
    else
      # Uncomment the part of code in the line below to enable limiting of the
      #   number of threads per page. Also uncomment some code on the
      #   views/show.html.hanl
      @comments = @post.comments.where(parent_id: nil)#.page(params[:page])
                                                      #.per(THREADS_PER_PAGE)
    end
  end

  def create
    @post = Post.new(post_params)

    # In spite of saving' success or failure a user must be redirected back to
    #   the wall where he tries to post
    # In case of failure flash would be used for transfer all neccessary
    #   information to the controller, that renders post' form

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
      params.require(:post).permit(:body, :wall_id, :user_id)
    end
end
