class OnionValidator < ActiveModel::Validator
  def validate(record)
    unless (record.onion_url =~ /(http(s)?\:\/\/)?[A-z,0-9]{16}.onion/) == 0
      record.errors[:base] << "Not a valid onion url"
    end
  end
end


class CrawlRequest < ActiveRecord::Base
  include ActiveModel::Validations

  before_validation :strip_url

  validates :onion_url, presence: true
  validates :onion_url, uniqueness: true
  validates_with OnionValidator

  def create(params)
    self.onion_url = params[:onion_url]
    self.indexed = false
    self.last_index = false
  end

  private

  def strip_url
    self.onion_url.gsub!(/http(s)?\:\/\//, "")
    self.onion_url.gsub!(/.onion\/*+/, ".onion/")
  end
end
