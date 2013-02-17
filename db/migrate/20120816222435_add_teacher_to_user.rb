class AddTeacherToUser < ActiveRecord::Migration
  def up
    add_column :users, :teacher, :boolean,
      :null => false,
      :default => false
  end

  def down
    remove_column :users, :teacher
    User.find_by_email('default@example.com').try(:delete)
  end
end
