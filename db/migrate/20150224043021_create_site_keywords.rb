class CreateSiteKeywords < ActiveRecord::Migration
  def change
    create_table :site_keywords do |t|
      t.string  :keyword
      t.decimal :weight
      t.decimal :percent
      t.integer :keyword_id
      t.integer :site_id
      t.timestamps null: false
    end
  end
end
