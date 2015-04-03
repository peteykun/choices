class AddSubjectIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subject_id, :integer
  end
end
