require 'rails_helper'

RSpec.describe "OnlyAdminMayDeleteGifs", type: :request do
  describe "GET /gifs" do
    it "allows admin to delete gif" do
      admin = User.new(username: 'admin', password: 'password', role: 1)

      ApplicationController.any_instance.stub(:current_user).and_return(admin)
      category = Category.create(name: 'kitten')
      category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')

      visit gifs_path

      click_on "Delete"

      expect(page).to_not have_content("kitten")
      expect(page).to_not have_css("img")

    end
  end

  describe "GET /gifs/1" do
    xit "works! (now write some real specs)" do
    end
  end
end
