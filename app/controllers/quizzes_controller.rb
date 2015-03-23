class QuizzesController < ApplicationController
  before_action :check_if_logged_in
  before_action :check_if_quiz_running

  def show
    @questions = Question.all.order(:id)
    @current_user = current_user

    @time_remaining = time_remaining
  end
end
