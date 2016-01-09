require 'rails_helper'

RSpec.describe "OnlyAdminMayDeleteGifs", type: :request do
  describe "GET /gifs" do
    it "allows admin to delete gif from index" do
      admin = User.create(username: 'admin', password: 'password', role: 1)

      ApplicationController.any_instance.stub(:current_user).and_return(admin)
      category = Category.create(name: 'kitten')
      category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')

      visit gifs_path

      click_on "Delete"

      expect(page).to_not have_content("kitten")
      expect(page).to_not have_css("img")
    end

    it "does not allow regular user to delete gif from index" do
      user = User.create(username: 'user', password: 'password', role: 0)

      ApplicationController.any_instance.stub(:current_user).and_return(user)
      category = Category.create(name: 'kitten')
      category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')

      visit gifs_path

      expect(page).to_not have_link("Delete")
    end

    it "does not delete category if gifs still exist for that category" do
      admin = User.create(username: 'admin', password: 'password', role: 1)

      ApplicationController.any_instance.stub(:current_user).and_return(admin)
      category = Category.create(name: 'kitten')
      category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')
      category.gifs.create(search_term: 'kitten', image_url: 'http://kittencute.com')

      visit gifs_path
      first(:link, 'Delete').click

      expect(page).to have_content("kitten")
      expect(page).to have_css("img[src*='http://kittencute.com']")
      expect(page).to_not have_css("img[src*='http://kitten.com']")
    end
  end

  describe "GET /gifs/1" do
    it "allows admin to delete gif from show" do
      admin = User.create(username: 'admin', password: 'password', role: 1)

      ApplicationController.any_instance.stub(:current_user).and_return(admin)
      category = Category.create(name: 'kitten')
      gif = category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')

      visit gif_path(gif)
      click_on "Delete"

      expect(current_path).to eq(gifs_path)
      expect(page).to_not have_content("kitten")
      expect(page).to_not have_css("img")
    end

    it "does not allow regular user to delete gif from show" do
      user = User.create(username: 'user', password: 'password', role: 0)

      ApplicationController.any_instance.stub(:current_user).and_return(user)
      category = Category.create(name: 'kitten')
      gif = category.gifs.create(search_term: 'kitten', image_url: 'http://kitten.com')

      visit gif_path(gif)

      expect(page).to_not have_link("Delete")
    end
  end
end
