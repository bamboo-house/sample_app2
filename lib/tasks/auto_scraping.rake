namespace :auto_scraping do
  task auto_scraping_task: :environment do
    Scraping.scrape_moshicom
    Scraping2.scrape_blueship
  end
end
