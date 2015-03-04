class Page < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :site

  attr_accessible :url, :title, :html_content, :text_content
end

