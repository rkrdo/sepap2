class AddMainToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :main, :string
  end
end
