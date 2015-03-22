class AddQuestionTypeToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :question_type, :integer
  end
end
