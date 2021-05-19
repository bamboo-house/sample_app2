class CreateScrapings < ActiveRecord::Migration[5.1]
  def change
    create_table :scrapings do |t|
      t.string :title

      t.timestamps
    end
  end
end
