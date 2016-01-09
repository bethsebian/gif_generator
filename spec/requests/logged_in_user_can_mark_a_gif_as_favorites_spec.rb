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
  end
end
