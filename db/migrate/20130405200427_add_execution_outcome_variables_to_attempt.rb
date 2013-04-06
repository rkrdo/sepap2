class AddExecutionOutcomeVariablesToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :accepted, :boolean, :default => true
    add_column :attempts, :time_exceeded, :boolean, :default => false
  end
end
