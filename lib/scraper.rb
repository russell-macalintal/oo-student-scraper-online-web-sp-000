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
    twitter_url = doc.css(".social-icon-container a").detect {|a| a.css("img")[0]["src"] == "../assets/img/twitter-icon.png"}
    linkedin_url = doc.css(".social-icon-container a").detect {|a| a.css("img")[0]["src"] == "../assets/img/linkedin-icon.png"}
    github_url = doc.css(".social-icon-container a").detect {|a| a.css("img")[0]["src"] == "../assets/img/github-icon.png"}
    blog_url = doc.css(".social-icon-container a").detect {|a| a.css("img")[0]["src"] == "../assets/img/rss-icon.png"}
    profile_quote = doc.css(".profile-quote")
    bio = doc.css(".bio-content.content-holder .description-holder p")

    if !twitter_url.nil?
      attributes[:twitter] = twitter_url["href"]
    end
    if !linkedin_url.nil?
      attributes[:linkedin] = linkedin_url["href"]
    end
    if !github_url.nil?
      attributes[:github] = github_url["href"]
    end
    if !blog_url.nil?
      attributes[:blog] = blog_url["href"]
    end
    if !profile_quote.nil?
      attributes[:profile_quote] = profile_quote.text
    end
    if !bio.nil?
      attributes[:bio] = bio.text
    end

    attributes
  end

end
