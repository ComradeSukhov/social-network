class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    # A user can post not only on its own wall
    #   but on any other user's wall too
    @post = current_user.posts.new
    @post.wall_id = Wall.where(user_id: params[:id]).ids[0]
  end
end
