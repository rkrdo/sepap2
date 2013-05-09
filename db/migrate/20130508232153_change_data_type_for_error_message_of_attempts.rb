class ChangeDataTypeForErrorMessageOfAttempts < ActiveRecord::Migration
  def up
    change_table :attempts do |t|
      t.change :error_message, :text
    end
  end

  def down
    change_table :attempts do |t|
      t.change :error_message, :string
    end
  end
end
