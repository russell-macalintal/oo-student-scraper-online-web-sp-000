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
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    attributes = {}
    twitter_url = doc.css(".social-icon-container a").detect {|a| a.css("img")[0]["src"] == "../assets/img/twitter-icon.png"}["href"]
    linkedin_url = doc.css(".social-icon-container a").select {|a| a.css("img")[0]["src"] == "../assets/img/linkedin-icon.png"}[0]["href"]
    github_url = doc.css(".social-icon-container a").select {|a| a.css("img")[0]["src"] == "../assets/img/github-icon.png"}[0]["href"]
    blog_url = doc.css(".social-icon-container a").select {|a| a.css("img")[0]["src"] == "../assets/img/rss-icon.png"}[0]["href"]
    profile_quote = doc.css(".profile-quote").text
    bio = doc.css(".bio-content.content-holder .description-holder p").text
    binding.pry
    attributes = {
      :twitter => twitter_url,
      :linkedin => linkedin_url,
      :github => github_url,
      :blog => blog_url,
      :profile_quote => profile_quote,
      :bio => bio
    }
  end

end
