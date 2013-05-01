class AddRunExtentionToCommands < ActiveRecord::Migration
  def change
    add_column :commands, :run_extension, :string
  end
end
