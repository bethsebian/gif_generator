require 'rails_helper'

RSpec.describe "AdminCanCreateANewGifs", type: :request do
  describe "GET /new_admin_gif" do
    it "admin creates a new gif with a category" do
      admin = User.create(username: 'admin', password: 'password', role: 1)

      ApplicationController.any_instance.stub(:current_user).and_return(admin)

      visit new_admin_gif_path

      fill_in "Search term", with: 'funny kitten'
      click_on "Get GIPHY"

      gif = Gif.last

      expect(Gif.count).to eq(1)
      expect(gif.category.name).to eq('funny kitten')
      expect(gif.search_term).to eq('funny kitten')

      expect(current_path).to eq(gif_path(gif))
    end

    it "general user cannot create a new gif" do
      user = User.create(username: 'user', password: 'password', role: 0)

      ApplicationController.any_instance.stub(:current_user).and_return(user)

      visit new_admin_gif_path

      expect(page).to have_content("The page you were looking for doesn't exist")
    end
  end
end
