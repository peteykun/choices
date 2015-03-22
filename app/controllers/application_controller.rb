class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def check_if_logged_in
    if current_user == nil
      redirect_to login_path
    end
  end

  def check_if_logged_out
    if current_user != nil
      redirect_to root_path
    end
  end

  def check_if_admin
    if current_user == nil or current_user.is_admin == false
      redirect_to root_path
    end
  end
end
