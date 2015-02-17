class CreatePhrases < ActiveRecord::Migration
  def change
    create_table :phrases do |t|
      t.string :text
      t.timestamps null: false
    end

    add_index :phrases, :text
  end
end
