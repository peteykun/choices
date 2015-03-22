class Admin::GameManagerController < ApplicationController
  layout 'admin'
  before_action :check_if_admin

  def index
  end

  def start
  end

  def stop
  end
end
