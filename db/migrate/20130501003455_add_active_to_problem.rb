class AddActiveToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :active, :boolean, default: false
  end
end
