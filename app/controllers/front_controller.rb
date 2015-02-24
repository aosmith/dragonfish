class FrontController < ApplicationController

  def index
  end

  def submit
  end

  def add_site
    @crawl_request = CrawlRequest.create(onion_url: params["onion_url"])
    if @crawl_request.save
      render status: 201, json: { crawl_request: @crawl_request }
    else
      render status: 400, json: { errors: @crawl_request.errors.full_messages }
    end
  end

  def search
    terms = params["terms"].split(" ")
    render json: { terms: terms }
  end

  private
end
