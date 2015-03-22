class RemoveCorrectOptionIdFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :correct_option_id, :integer
  end
end
