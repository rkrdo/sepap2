class AddCodeToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :code, :text
  end
end
