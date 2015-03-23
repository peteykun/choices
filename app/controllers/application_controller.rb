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

  def time_remaining
    unless quiz_running?
      return 0
    else
      start_time = ConfigTable.find_by_key('start_time').value.to_time
      time_to_add = ConfigTable.find_by_key('total_time').value.to_i

      return ((start_time + time_to_add.seconds) - Time.now).round
    end
  end

  def quiz_running?
    start_time = ConfigTable.find_by_key('start_time')
    time_to_add = ConfigTable.find_by_key('total_time').value.to_i

    # Check if game actually started
    if start_time == nil or start_time.value == nil
      return false
    else
      start_time = start_time.value.to_time
    end

    # Check if game expired
    if start_time + time_to_add.seconds > Time.now
      return true
    else
      return false
    end
  end

  def check_if_quiz_running
    unless quiz_running?
      redirect_to lobby_path
    end
  end

end
