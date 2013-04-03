class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.boolean :result
      t.references :case
      t.references :attempt

      t.timestamps
    end
    add_index :results, :case_id
    add_index :results, :attempt_id
  end
end
