class CreatePhrasesUrls < ActiveRecord::Migration
  def change
    create_table :phrases_urls do |t|
      t.integer  :url_id
      t.integer  :phrase_id
      t.float    :weight
      t.timestamps null: false
    end

    add_index :phrases_urls, :weight
    add_index :phrases_urls, :url_id
    add_index :phrases_urls, :phrase_id

  end
end
