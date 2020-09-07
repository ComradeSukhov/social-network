class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    # Get all users except current
    # And get amount of posts on each user's wall
    @users = Wall.left_outer_joins(:owner, :posts)
                 .select('users.id',
                         "#{full_name} AS name",
                         'count(posts.id) AS posts_amount')
                 .group('users.id')
                 .where("users.id != #{ current_user.id }")
                 .order(:name)
  end

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
    # Method .includes isn't used here because there might be a lot of comments
    @posts = Post.left_outer_joins(:author, :comments)
                 .select(
                   :id,
                   :body,
                   :created_at,
                   :author_id,
                   "#{full_name} AS author_name",
                   'count(comments.id) AS comments_amount')
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
