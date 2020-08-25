module SessionsHelper
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user?(user)
    user == current_user
  end

  def log_in(user)
    session[:user_id] = user.id
  end

    def logged_in?
      current_user.present?
    end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def redirect_if_not_logged_in
    redirect_back(fallback_location: root_url) unless logged_in?
  end

  def redirect_if_logged_in
    redirect_back(fallback_location: user_url(current_user[:id])) if logged_in?
  end
end
