class AddReviewToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :review, :boolean
  end
end
