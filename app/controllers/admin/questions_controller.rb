class Admin::QuestionsController < ApplicationController
  before_action :check_if_admin
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  layout 'admin'

  def index
    @questions = Question.order(:id).paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def edit
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save

      # Update the options (multiple-choice type) or correct answer (numerical type)
      if @question.question_type == 'multiple_choice'
        params[:options].each do |key, value|
          if key == params[:correctChoice]
            Option.create(question_id: @question.id, body: value, correct: true)
          else
            Option.create(question_id: @question.id, body: value, correct: false)
          end
        end
      end

      redirect_to [:admin, @question], notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)

      @question.options.destroy_all
      
      # Update the options (multiple-choice type) or correct answer (numerical type)
      if @question.question_type == 'multiple_choice'
        params[:options].each do |key, value|
          if key == params[:correctChoice]
            Option.create(question_id: @question.id, body: value, correct: true)
          else
            Option.create(question_id: @question.id, body: value, correct: false)
          end
        end
      end

      redirect_to [:admin, @question], notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.options.destroy_all
    @question.destroy

    redirect_to admin_questions_url, notice: 'Question was successfully destroyed.'
  end

  private
    def set_question
      @question = ::Question.find(params[:id])
      @options = Hash.new
      count = 'a'

      @question.options.order(:id).each do |option|
        @options[count] = option
        count.next!
      end
    end

    def question_params
      params.require(:question).permit(:name, :body, :question_type, :answer, :subject_id)
    end
end
