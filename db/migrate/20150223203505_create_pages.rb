class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :site_id
      t.string  :url
      t.timestamps null: false
    end
  end
end
