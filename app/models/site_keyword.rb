class SiteKeyword < ActiveRecord::Base
  belongs_to :site
  belongs_to :keywork

  validates :keyword, uniquness: { scope: :site }

  def create(args)
  end

end
