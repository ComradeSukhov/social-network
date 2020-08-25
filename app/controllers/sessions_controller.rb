class SessionsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:new, :create]
  before_action :redirect_if_logged_in,     only:   [:new, :create]

  def new; end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      log_in(user)
      redirect_to user_url(current_user[:id]), notice: 'Signed in'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: 'Signed out'
  end
end
