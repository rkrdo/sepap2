class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :subject
      t.string :period
      t.string :name

      t.timestamps
    end
    add_index :groups, :subject_id
  end
end
