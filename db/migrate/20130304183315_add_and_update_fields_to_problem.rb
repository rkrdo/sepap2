class AddAndUpdateFieldsToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :dificulty, :string
  end
end
