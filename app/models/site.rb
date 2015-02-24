class Site < ActiveRecord::Base

  has_many :crawl_requests

  validates :base_url, presence: true
  validates :base_url, uniquness: true
end
