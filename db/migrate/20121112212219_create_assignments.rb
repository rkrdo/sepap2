class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.references :problem
      t.references :group
      t.date :due_date

      t.timestamps
    end
    add_index :assignments, :problem_id
    add_index :assignments, :group_id
  end
end
