class AddNumToUsers < ActiveRecord::Migration
  def change
    add_column :users, :num, :string
  end
end
