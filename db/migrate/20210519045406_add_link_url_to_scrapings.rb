class AddLinkUrlToScrapings < ActiveRecord::Migration[5.1]
  def change
    add_column :scrapings, :link_url, :string
  end
end
