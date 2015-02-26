class OnionValidator < ActiveModel::Validator
  def validate(record)
    unless (record.onion_url =~ /(http(s)?\:\/\/)?[A-z,0-9]{16}\.onion/) == 0
      record.errors[:base] << "Not a valid onion url"
    end
  end
end


class CrawlRequest < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :site

  before_validation :strip_url!

  after_commit :queue_job

  validates :onion_url, presence: true
  validates :onion_url, uniqueness: true
  validates_with OnionValidator

  attr_accessible :onion_url

  def create(params)
    self.onion_url = params[:onion_url]
    self.indexed = false
    self.last_index = false
  end

  def base_url
    return self.onion_url.gsub(/\.onion\/.*/, ".onion/")
  end

  private

  def strip_url!
    self.onion_url.gsub!(/http(s)?\:\/\//, "")
  end

  def queue_job
    CrawlJob.perform_later self
  end
end
