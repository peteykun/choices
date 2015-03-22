class StaticPagesController < ApplicationController
  layout 'user_area'
  before_action :check_if_logged_in
  
  def lobby
  end
end
