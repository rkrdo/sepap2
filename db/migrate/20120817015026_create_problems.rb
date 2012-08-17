class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.text :description
      t.float :time
      t.boolean :module

      t.timestamps
    end
  end
end
