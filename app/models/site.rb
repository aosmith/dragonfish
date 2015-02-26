class Site < ActiveRecord::Base
  has_many :crawl_requests

  validates :base_url, presence: true
  validates :base_url, uniqueness: true

  attr_accessible :base_url
end
