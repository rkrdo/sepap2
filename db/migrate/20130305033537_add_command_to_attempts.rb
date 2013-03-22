class AddCommandToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :command_id, :integer
    add_index :attempts, :command_id
  end
end
