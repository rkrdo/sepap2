class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :problem
      t.integer :line_number
      t.string :comment

      t.timestamps
    end
    add_index :feedbacks, :problem_id
  end
end
