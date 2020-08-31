class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def show
    if params[:comment]
      @comments = @post.comments.where(id: params[:comment])
    else
      # Uncomment the part of code in the line below to enable limiting of the
      #   number of threads per page. Also uncomment some code on the
      #   views/show.html.hanl
      @comments = @post.comments.where(parent_id: nil)#.page(params[:page]).per(5)
    end
  end

  def create
    @post = Post.new(post_params)

    unless @post.save
      # Flash is being used for transfer all neccessary information
      #   to another controller in case of failing to save
      flash[:post]  = @post
      flash[:alert] = @post.errors.full_messages
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
