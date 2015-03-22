class QuizzesController < ApplicationController
  before_action :check_if_logged_in

  def show
    redirect_to lobby_path

    @questions = Question.all.order(:id)
    @current_user = current_user
  end
end
