class Admin::GameManagerController < ApplicationController
  layout 'admin'
  before_action :check_if_admin

  def index
    @quiz_running = quiz_running?
    @time_remaining = time_remaining
  end

  def start
    unless quiz_running?
      Answer.all.destroy_all

      start_time = ConfigTable.find_by_key('start_time')
      start_time.update(value: Time.now)
    end

    redirect_to admin_game_manager_path
  end

  def stop
    if quiz_running?
      start_time = ConfigTable.find_by_key('start_time')
      start_time.update(value: nil)
    end

    redirect_to admin_game_manager_path
  end
end
