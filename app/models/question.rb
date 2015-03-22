class Question < ActiveRecord::Base
  enum question_type: [ :multiple_choice, :numerical ]
  has_many :options
  has_many :answers

  validates_presence_of :name, :body

  def correct_option
    self.options.find_by_correct(true)
  end

  def find_answer_by(user)
    result = Answer.where(question: self, user: user)

    return nil if result.size == 0
    return result.first
  end
end
