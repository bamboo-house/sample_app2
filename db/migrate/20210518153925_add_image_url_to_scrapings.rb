class AddImageUrlToScrapings < ActiveRecord::Migration[5.1]
  def change
    add_column :scrapings, :image_url, :string
  end
end
