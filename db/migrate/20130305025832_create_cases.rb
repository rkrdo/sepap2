class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.text :input
      t.text :output
      t.references :problem

      t.timestamps
    end
    add_index :cases, :problem_id
  end
end
