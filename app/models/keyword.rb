class Keyword < ActiveRecord::Base
  has_many :sites, through: :site_keywords

  validates :keyword, presence: true
  validates :keyword, uniquness: true

  attr_writer :keyword
end
