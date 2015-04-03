class QuizzesController < ApplicationController
  before_action :check_if_logged_in
  before_action :check_if_quiz_running

  def show
    @questions = current_user.subject.questions.order(:id)
    @current_user = current_user

    @time_remaining = time_remaining
  end
end
