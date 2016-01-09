require 'rails_helper'

RSpec.describe "LoggedInUserCanMarkAGifAsFavorites", type: :request do
  describe "GET /gifs" do
    it "let logged in user favorite an image" do
      user = User.create(username: 'user', password: 'password', role: 0)

      ApplicationController.any_instance.stub(:current_user).and_return(user)
      category = Category.create(name: 'kitten')
      category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')

      visit gifs_path
      click_on "Save to Favorites"

      expect(current_path).to eq(user_favorites_path(user))
      expect(page).to have_content('kitten')
      expect(page).to have_css("img[src*='http://kitten.com']")
    end

    it "only show user's favorites in index" do
      user_1 = User.create(username: 'user_1', password: 'password', role: 0)
      user_2 = User.create(username: 'user_2', password: 'password', role: 0)

      ApplicationController.any_instance.stub(:current_user).and_return(user_1)

      category = Category.create(name: 'horse')
      gif_1 = category.gifs.create(search_term: 'horse', image_url: 'http://horse.com')

      category_2 = Category.create(name: 'kitten')
      gif_2 = category_2.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')

      user_2.favorites.create(user_id: user_2.id, gif_id: gif_2.id)

      visit gifs_path

      first(:button, 'Save to Favorites').click

      expect(current_path).to eq(user_favorites_path(user_1))
      expect(page).to have_content('horse')
      expect(page).to have_css("img[src*='http://horse.com']")

      expect(page).to_not have_content('kitten')
      expect(page).to_not have_css("img[src*='http://kitten.com']")
    end
  end
end
