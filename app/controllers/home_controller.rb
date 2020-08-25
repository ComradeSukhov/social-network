class HomeController < ApplicationController
  before_action :redirect_if_logged_in

  def index
    @user = User.new
  end
end
