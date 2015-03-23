class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  def is_correct?
    case self.question.question_type

    when 'multiple_choice'
      return Option.find(self.answer).correct

    when 'numerical'
      return self.answer == self.question.answer

    end
  end

  def given_answer
    case self.question.question_type
    when 'multiple_choice'
      return Option.find(self.answer).body

    when 'numerical'
      return self.answer
      
    end
  end

  def marks
    correct_marks    = ConfigTable.find_by_key('correct_marks').value.to_i
    incorrect_marks  = ConfigTable.find_by_key('incorrect_marks').value.to_i

    case self.question.question_type
    when 'multiple_choice'
      if self.is_correct?
        return correct_marks
      else
        return -1 * incorrect_marks
      end

    when 'numerical'
      if self.is_correct?
        return correct_marks
      else
        return 0
      end
      
    end
  end
end
