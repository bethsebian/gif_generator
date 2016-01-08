class AddCategoryIdToGifs < ActiveRecord::Migration
  def change
    add_reference :gifs, :category, index: true, foreign_key: true
  end
end
