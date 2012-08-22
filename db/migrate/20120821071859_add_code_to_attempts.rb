class AddCodeToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :code, :string
  end
end
