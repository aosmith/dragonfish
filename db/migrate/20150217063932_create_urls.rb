class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :onion_address
      t.timestamps null: false
    end
    add_index :urls, :onion_address
  end
end
