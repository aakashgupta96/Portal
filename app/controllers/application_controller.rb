class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  add_flash_types :pop
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user

  def after_sign_in_path_for(resource)
   '/dashboard'
  end
  protected

  def configure_permitted_parameters
    added_attrs = [:contact_no, :email, :username, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_user
    if user_signed_in?
      @user = current_user
    else
      @user = User.new()
    end
  end

end
