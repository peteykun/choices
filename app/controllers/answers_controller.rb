class AnswersController < ApplicationController
  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_user

    search_result = Answer.where(user: current_user, question: @answer.question).order(:id)

    if search_result.size == 0
      render json: @answer.save
    else
      render json: search_result.first.update(answer: @answer.answer, review: @answer.review)
    end
  end

  def destroy
    search_result = Answer.where(user: current_user, question: Question.find(params[:id]))

    if search_result.size == 0
      render json: true
    elsif search_result.size == 1
      search_result.first.destroy
      render json: true
    else
      render json: false
    end
  end

  private
    def answer_params
      params.require(:answer).permit(:question_id, :answer, :review)
    end
end
