class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :body
      t.integer :question_id

      t.timestamps null: false
    end
  end
end
