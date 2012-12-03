class AddTeacherToUser < ActiveRecord::Migration
  def up
    add_column :users, :teacher, :boolean,
                                    :null => false,
                                    :default => false
    User.create! do |r|
      r.email      = 'admin@sepap.com'
      r.password   = '121212'
      r.password_confirmation   = '121212'
      r.num = 'A12121212'
      r.teacher = true
    end
    User.create! do |r|
      r.email      = 'L00904961@itesm.mx'
      r.password   = '121212'
      r.password_confirmation   = '121212'
      r.num = 'L00904961'
      r.teacher = true
    end
    User.create! do |r|
      r.email      = 'L00163642@itesm.mx'
      r.password   = '121212'
      r.password_confirmation   = '121212'
      r.num = 'L00163642'
      r.teacher = true
    end
  end

  def down
    remove_column :users, :teacher
    User.find_by_email('default@example.com').try(:delete)
  end
end
