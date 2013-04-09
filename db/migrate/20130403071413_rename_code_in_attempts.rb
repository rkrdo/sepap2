class RenameCodeInAttempts < ActiveRecord::Migration
  def up
    change_column :attempts, :code, :text
  end

  def down
    change_column :attempts, :code, :string
  end
end
