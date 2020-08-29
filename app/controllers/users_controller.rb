class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @wall = @user.wall
    @name = "#{ @user.first_name } #{ @user.last_name }"
    if flash[:post]
      # If a new post have failed validations and have been redirected here
      #   flash contains all neccessary information about that post
      @post   = Post.new(flash[:post])
      @errors = flash[:errors]
    else
      @post = current_user.posts.new
      @post.wall_id = @wall.id
    end
  end
end
