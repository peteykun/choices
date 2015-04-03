class User < ActiveRecord::Base
  validates_presence_of    :email, :username, :name, :college, :phone
  validates                :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates                :username, length: { maximum: 8 }
  validates                :is_admin, inclusion: { in: [true, false] }
  validates_uniqueness_of  :email, :username

  has_many    :answers
  belongs_to  :subject
  has_secure_password

  def score
    correct_marks    = ConfigTable.find_by_key('correct_marks').value.to_i
    incorrect_marks  = ConfigTable.find_by_key('incorrect_marks').value.to_i
    score = 0

    self.answers.each do |answer|
      case answer.question.question_type
      when 'multiple_choice'

        if answer.is_correct?
          score += correct_marks
        else
          score -= incorrect_marks
        end

      when 'numerical'

        if answer.is_correct?
          score += correct_marks
        end

      end
    end

    return score
  end
end
