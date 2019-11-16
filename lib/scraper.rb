require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    name = doc.css(".student-name")
    location = doc.css(".student-location")
    profile_url = doc.css(".student-card a")
    c = 0
    name.size.times do
      student_array << {
        :name => name[c].text,
        :location => location[c].text,
        :profile_url => profile_url[c]["href"]
      }
      c += 1
    end
    student_array
  end

  def self.scrape_profile_page(profile_url)

  end

end
