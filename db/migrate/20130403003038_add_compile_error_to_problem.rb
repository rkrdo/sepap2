class AddCompileErrorToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :compile_error, :boolean, :default => false
    add_column :problems, :error_message, :string
  end
end
