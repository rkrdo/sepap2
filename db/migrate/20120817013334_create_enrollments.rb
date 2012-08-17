class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.references :user
      t.references :group

      t.timestamps
    end
    add_index :enrollments, :user_id
    add_index :enrollments, :group_id
  end
end
