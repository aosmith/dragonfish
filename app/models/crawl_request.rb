class CrawlRequest < ActiveRecord::Base
  attr_accessor :onion_url, :raw_content, :indexed
end
