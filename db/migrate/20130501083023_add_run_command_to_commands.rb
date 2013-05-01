class AddRunCommandToCommands < ActiveRecord::Migration
  def change
    add_column :commands, :run_command, :string
  end
end
