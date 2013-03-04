class CreateCommands < ActiveRecord::Migration
  def change
    create_table :commands do |t|
      t.string :name
      t.string :compile_command
      t.text :description

      t.timestamps
    end
  end
end
