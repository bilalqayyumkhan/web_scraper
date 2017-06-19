class ScraperController < ApplicationController
  def home
  end

  def scrape
    web_page = Scraper.new(params[:url])
    web_page.highlight(params[:tag]) if params[:tag].present?

    @page_source = web_page.page_source
    @tags_count = web_page.tags_count
  end
end
