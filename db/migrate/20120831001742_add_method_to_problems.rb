class AddMethodToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :method, :string
  end
end
