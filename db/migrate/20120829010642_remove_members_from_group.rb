class RemoveMembersFromGroup < ActiveRecord::Migration
  def up
    remove_column :groups, :members
      end

  def down
    add_column :groups, :members, :string
  end
end
