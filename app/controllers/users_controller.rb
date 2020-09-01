class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]

  def show
    @wall = @user.wall
    @name = "#{ @user.first_name } #{ @user.last_name }"

    if flash[:failed_post]
      # If a user already had tried to post and have failed validations
      #   flash would contain all neccessary information about that failed post
      @post = Post.new(flash[:failed_post])
    else
      @post = current_user.posts.new
      @post.wall_id = @wall.id
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
