class AddCompilingErrorsToAttempt < ActiveRecord::Migration
  def change
    add_column :attempts, :compile_error, :boolean, :default => false
    add_column :attempts, :error_message, :string
  end
end
