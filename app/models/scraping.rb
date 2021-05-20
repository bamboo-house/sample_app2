class Scraping < ApplicationRecord

  def self.scrape_moshicom
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

