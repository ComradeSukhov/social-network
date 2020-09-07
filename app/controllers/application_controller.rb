class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :auth_is_not_required?


  # Return a string that shall be used in a sql query to get a full user's name
  def full_name
    "users.first_name || ' ' || users.last_name"
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,
                                                         :last_name])
    end

  private
    def auth_is_not_required?
      devise_controller? || controller_name == 'welcome_pages'
    end
end
