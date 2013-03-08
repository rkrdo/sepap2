class AddCommandToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :command_id, :integer
  end
end
