class AddExeToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :exe, :string
  end
end
