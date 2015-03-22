class QuizzesController < ApplicationController
  def show
    @questions = Question.all.order(:id)
    @current_user = current_user
  end
end
