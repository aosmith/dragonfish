class CreateCrawlRequests < ActiveRecord::Migration
  def change
    create_table :crawl_requests do |t|
      t.string     :onion_url
      t.boolean    :indexed
      t.timestamp  :last_index
      t.timestamps null: false
    end
  end
end
