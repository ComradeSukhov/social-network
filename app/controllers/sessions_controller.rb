class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      helpers.log_in(user)
      redirect_to user_url(helpers.current_user[:id]), notice: 'Signed in'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    helpers.log_out
    redirect_to root_url, notice: 'Signed out'
  end
end
