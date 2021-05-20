class Scraping2 < ApplicationRecord

  def self.scrape_blueship
    driver = Selenium::WebDriver.for :chrome
    driver.get("https://moshicom.com/search/?s=3&keyword=&event_start_date=&event_end_date=&entry_status=yes&except_eventup=no&scale=0&disciplines%5B%5D=11&wanted%5B%5D=999&day_entry=no&measurement=no&user_id=0&search_type=0&recommend_event=true&recommend_course=true&recommend_facility=true&mode=1&l=20&o=0&m=1")
    
    event_titles = driver.find_elements(:xpath, '//*[@id="event_search"]/div/div/section/div/div/h3/a')
    group_names = driver.find_elements(:xpath, '//*[@id="event_search"]/div/div/section/div/div/div/dl/dd/div/h4/a')

    event_titles.zip(group_names, event_titles) do |title, name, link_url|
      unless self.find_by(title: title.text)
        data = self.new 
        data.title = title.text
        data.name = name.text
        data.link_url = link_url.attribute('href')
        data.save
      end
    end
    driver.quit
  end
end
