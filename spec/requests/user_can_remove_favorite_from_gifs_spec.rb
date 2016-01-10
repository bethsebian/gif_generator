require 'rails_helper'

RSpec.describe "UserCanRemoveFavoriteFromGifs", type: :request do
  describe "DELETE /user_favorites" do
    it "lets user remove gif from favorites" do
      user = User.create(username: 'user', password: 'password', role: 0)

      ApplicationController.any_instance.stub(:current_user).and_return(user)
      category = Category.create(name: 'kitten')
      gif = category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')
      favorite = user.favorites.create(user_id: user.id, gif_id: gif.id)

      visit user_favorite_path(user, favorite)

      click_on "Delete"

      expect(current_path).to eq(user_favorites_path(user))
      expect(page).to_not have_content('kitten')
      expect(page).to_not have_css("img[src*='http://kitten.com']")
    end
  end
end
