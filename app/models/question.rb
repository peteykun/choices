class Question < ActiveRecord::Base
  enum question_type: [ :multiple_choice, :numerical ]
  has_many :options

  validates_presence_of :name, :body

  def correct_option
    self.options.find_by_correct(true)
  end
end
