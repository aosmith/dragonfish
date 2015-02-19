class CreateCrawlRequests < ActiveRecord::Migration
  def change
    create_table :crawl_requests do |t|
      t.string     :onion_url
      t.text       :raw_content
      t.boolean    :indexed
      t.timestamps null: false
    end
  end
end
