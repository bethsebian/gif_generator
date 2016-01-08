require 'rails_helper'

RSpec.describe "AdminCanCreateANewGifs", type: :request do
  describe "GET /new_admin_gif" do
    it "creates a new gif with a category" do
      admin = User.new(username: 'admin', password: 'password', role: 1)

      # ApplicationController.any_instance.stub(session[:user_id]).returns(admin.id)
      ApplicationController.any_instance.stub(:current_user).with(admin)

      visit new_admin_gif_path

      fill_in "Search term", with: 'funny kitten'
      click_on "Get GIPHY"

      expect(Gif.count).to eq(1)
      expect(Gif.last.category.name).to eq('funny kitten')
      expect(Gif.last.search_term).to eq('funny kitten')

      expect(current_path).to eq(gif_path(Gif.last))
    end
  end
end
