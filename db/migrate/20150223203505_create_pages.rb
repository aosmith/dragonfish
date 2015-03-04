class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :site_id
      t.string :url
      t.string :title
      t.string :html_content
      t.string :text_content
      t.timestamps null: false
    end
  end
end
