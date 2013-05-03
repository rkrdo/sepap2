class RemoveOldAttributesFromAttempt < ActiveRecord::Migration
  def up
    remove_column :attempts, :outcome
    remove_column :attempts, :language
    remove_column :attempts, :compile_error
    remove_column :attempts, :accepted
    remove_column :attempts, :time_exceeded
    remove_column :attempts, :compiled
  end

  def down
    add_column :attempts, :compiled, :boolean
    add_column :attempts, :time_exceeded, :boolean
    add_column :attempts, :accepted, :boolean
    add_column :attempts, :compile_error, :boolean
    add_column :attempts, :language, :string
    add_column :attempts, :outcome, :string
  end
end
