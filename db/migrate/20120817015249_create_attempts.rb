class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.references :problem
      t.references :user
      t.references :assignment
      t.string :outcome
      t.string :language

      t.timestamps
    end
    add_index :attempts, :problem_id
    add_index :attempts, :user_id
  end
end
