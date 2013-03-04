class RemoveUnusedColumnsFromProblem < ActiveRecord::Migration
  def up
    remove_column :problems, :title
    remove_column :problems, :description
    remove_column :problems, :input
    remove_column :problems, :output
    remove_column :problems, :exe
    change_column :problems, :main, :text
    change_column :problems, :method, :text
  end

  def down
    change_column :problems, :main, :string
    change_column :problems, :method, :string
    add_column :problems, :exe, :string
    add_column :problems, :output, :string
    add_column :problems, :input, :string
    add_column :problems, :description, :text
    add_column :problems, :title, :string
  end
end
