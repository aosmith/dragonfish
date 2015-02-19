class FrontController < ApplicationController

  def index
  end

  def submit
  end

  def add_site
    @crawl_request = CrawlRequest.new(params[:crawl_request])
    if @crawl_request.valid?
      @crawl_request.save
      template nil
      render status: 201
    else
      template nil
      render status: 400
    end
  end

  def search
    terms = params["terms"].split(" ")
    render json: { terms: terms }
  end
end
