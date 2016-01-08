
require 'rails_helper'

RSpec.describe "UserCanViewListOfGifs", type: :request do
  describe "GET /gifs" do
    it "shows a list of gifs by category" do
      kitten_category = Category.create(name: 'kitten')
      kitten_gif = kitten_category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.cute')

      piglet_category = Category.create(name: 'piglet')
      piglet_gif = piglet_category.gifs.create(search_term: 'piglet', image_url: 'http://piglet.com')

      visit gifs_path
      within '#kitten' do
        expect(page).to have_css("img[src*='http://kitten.cute']")
        expect(page).to have_content('kitten')
      end

      within '#piglet' do
        expect(page).to have_css("img[src*='http://piglet.com']")
        expect(page).to have_content('piglet')
      end
    end
  end
end
