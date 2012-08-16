class AddTeacherToUser < ActiveRecord::Migration
  def up
    add_column :users, :teacher, :boolean,
                                    :null => false,
                                    :default => false
    User.create! do |r|
      r.email      = 'admin@sepap.com'
      r.password   = '121212'
      r.teacher = true
    end
  end

  def down
    remove_column :users, :teacher
    User.find_by_email('default@example.com').try(:delete)
  end
end
