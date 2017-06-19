require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'

class Scraper
  attr_accessor :url, :web_page

  def initialize(url)
    url = "http://" + url unless url.index("http") || url.index("https")
    self.url = url
    self.web_page = Nokogiri::HTML(open(self.url, allow_redirections: :safe).read, nil, "UTF-8")
  end

  def tags_count
    tags_hash = {}
    web_page.traverse do |node|
      if !node.cdata? && !node.comment? && !node.text? && !node.html?
        tags_hash["#{node.name}"] = tags_hash["#{node.name}"].to_i + 1
      end
    end
    tags_hash
  end

  def page_source
    web_page.to_html
  end

  def highlight(tag)
    web_page.search(tag).wrap("<mark></mark>")
  end
end