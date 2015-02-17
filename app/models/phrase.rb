class Phrase < ActiveRecord::Base
  has_many :phrases_urls
  has_many :urls, through: :phrases_urls
end
