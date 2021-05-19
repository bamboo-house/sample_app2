class Scraping < ApplicationRecord
  require 'mechanize'
  def self.scrape
    agent = Mechanize.new                  #agentは任意の変数
    page = agent.get("https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc&per_page=108.") 
    
    #pageは任意の変数 getの引数はサイトのURL
    elements = page.search('h2.event_title a') #div.idxcol aは取得したい要素  elementsは任意の変数
    puts elements
    elements.each do |element|
      fish = Scraping.new     #Fishは任意のクラス、fishは任意のインスタンス
      fish.title = element.inner_text
      fish.save
    end
  end

  def self.scrape2
    agent = Mechanize.new
    current_url = "https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc"

    while true do
      current_page = agent.get(current_url)
      elements = current_page.search("h2.event_title a")
      elements.each do |element|
        fish = Scraping.new     #Fishは任意のクラス、fishは任意のインスタンス
        fish.title = element.inner_text
        fish.save
      end
      next_link =current_page.at(".pager a")
      if next_link.get_attribute('a[rel=next]')
        current_url = next_link.get_attribute('href')
      else
        break
      end
    end
  end
  def self.scrape3
    agent = Mechanize.new
    for i in 0..7
      current_page = agent.get("https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc&per page=#{18*i}")
      event_titles = current_page.search("h2.event_title a")
      group_names = current_page.search(".crew_info p")
      group_images = current_page.search(".crew_info img") 

      event_titles.zip(group_names, group_images, event_titles) do |title, name, image, link_url|
        unless self.find_by(title: title.text)
          data = self.new
          data.title = title.inner_text
          data.name = name.inner_text
          data.link_url = link_url.get_attribute('href')
          data.image_url = image.get_attribute('src')
          data.save
        end
      end
    end
  end
end

