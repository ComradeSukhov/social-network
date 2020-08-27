class HomeController < ApplicationController
  before_action :allow_only_not_signed_in_users

  def index; end
end

private
  def allow_only_not_signed_in_users
    redirect_to user_path(current_user) if user_signed_in?
  end
