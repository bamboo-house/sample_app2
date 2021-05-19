class CreateScraping2s < ActiveRecord::Migration[5.1]
  def change
    create_table :scraping2s do |t|
      t.string :title
      t.string :name
      t.string :link_url
      t.string :image_url

      t.timestamps
    end
  end
end
