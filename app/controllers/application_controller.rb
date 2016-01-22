class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_update_path_for(resource)
    user_path(current_user)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :first_name, :last_name, :email, :password, :password_confirmation
      )
    end

    devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :email, :avatar]

    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:email, :password, :remember_me)
    end
  end

end
