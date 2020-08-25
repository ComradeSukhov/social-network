class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      helpers.log_in(@user)
      redirect_to root_url, notice: 'You signed up successfully'
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
