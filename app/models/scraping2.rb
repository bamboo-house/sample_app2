class Scraping2 < ApplicationRecord
  require 'mechanize'

  def self.scrape3
    agent = Mechanize.new
    
    current_page = agent.get("https://moshicom.com/search/?s=3&keyword=&event_start_date=&event_end_date=&entry_status=yes&except_eventup=no&scale=0&disciplines%5B%5D=11&day_entry=no&measurement=no&user_id=0&search_type=0&recommend_event=true&recommend_course=true&recommend_facility=true&mode=1&l=20&o=0&m=1")
    puts current_page
    event_titles = current_page.search(".card-body h3")
    group_names = current_page.search(".user a")
    group_images = current_page.search(".user-icon img")
    
    puts event_titles.to_html
    event_titles.each do |title|
      puts title.inner_text
    end
    puts group_names.inner_text
    group_images.each do |image|
      puts image.get_attribute('src')
    end
    # event_titles.zip(group_names, group_images,event_titles) do |title, name, image, link_url|
    #   fish = self.new
    #   fish.title = title.inner_text
    #   fish.name = name.inner_text
    #   fish.link_url = link_url.get_attribute('href')
    #   fish.image_url = image.get_attribute('src')
    #   fish.save
    # end
  end

  def self.scrape4
    require 'open-uri'
    require 'json'
    file = open("https://moshicom.com/api/search/events.json?s=3&keyword=&event_start_date=&event_end_date=&entry_status=yes&except_eventup=no&scale=0&disciplines[]=11&day_entry=no&measurement=no&user_id=0&search_type=0&recommend_event=true&recommend_course=true&recommend_facility=true&mode=1&l=20&o=0&m=1")
    
    file_array = JSON.parse(file)
    puts file_array
  end
  
  def self.scrape5
    require 'selenium-webdriver'

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
    # event_titles.zip(group_names, event_titles) do |title, name, link_url|
    #   data = self.where(title: title).first_or_initialize
    #   data.name = name.text
    #   data.link_url = link_url.attribute('href')
    #   data.save
    # end
    
    driver.quit
  end
end
