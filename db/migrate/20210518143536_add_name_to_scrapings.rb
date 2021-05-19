class AddNameToScrapings < ActiveRecord::Migration[5.1]
  def change
    add_column :scrapings, :name, :string, after: :title
  end
end
