class AddIoToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :input, :string
    add_column :problems, :output, :string
  end
end
