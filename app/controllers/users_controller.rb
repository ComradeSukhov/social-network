class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @wall = @user.wall

    # ===> This part of code is related to the post creation form
    if flash[:failed_post]
      # If a user already have tried to post and have failed validations
      #   flash contains all neccessary information about that failed post
      @post = Post.new(flash[:failed_post])
    else
      @post = current_user.posts.new(wall_id: @wall.id)
    end
    # <=== end

    # Get all posts on the wall
    #   and all neccessary information to display each post
    @posts = Post.left_outer_joins(:author, :comments)
                 .select(
                   :id,
                   :body,
                   :created_at,
                   :author_id,
                   "users.first_name || ' ' || users.last_name AS author_name",
                   'count(comments.id) AS comments_quantity')
                 .group(:id, :first_name, :last_name)
                 .where(wall_id: @wall.id)
                 .order(:created_at)
                 .reverse_order
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
