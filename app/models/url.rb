class Url < ActiveRecord::Base
  has_many :phrases_urls
  has_many :phrases, through: :phrases_urls
end
