class Site < ActiveRecord::Base

  has_many :crawl_requests
  has_many :keywords, through: :site_keywords

  validates :base_url, presence: true
  validates :base_url, uniquness: true
end
