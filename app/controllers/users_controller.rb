class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:new, :create]
  before_action :redirect_if_logged_in,     only:   [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to user_url(current_user[:id]),
        notice: 'You signed up successfully'
    else
      flash.now[:alert] = 'Sorry, try again!'
      render :new
    end
  end

  def show; end
end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
