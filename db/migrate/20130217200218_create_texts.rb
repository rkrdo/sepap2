class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :textable_type
      t.integer :textable_id
      t.string :text_identifier
      t.text :text_content
      t.string :locale

      t.timestamps
    end
  end
end
