class AddAnswerFieldsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :answer, :integer
    add_column :questions, :correct_option_id, :integer
  end
end
