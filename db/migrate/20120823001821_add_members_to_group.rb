class AddMembersToGroup < ActiveRecord::Migration
  def change
    add_column :groups, :members, :string
  end
end
