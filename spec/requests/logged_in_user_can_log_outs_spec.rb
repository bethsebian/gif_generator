require 'rails_helper'

RSpec.describe "LoggedInUserCanLogOuts", type: :request do
  describe "GET /logout" do
    it "destroys the current session and logs user out" do
      user = User.create(username: 'user', password: 'password')

      visit login_path
      fill_in "Username", with: "user"
      fill_in "Password", with: "password"
      click_button "Log in"

      click_on "Log out"

      expect(page).to have_content("Successfully Logged Out!")
      expect(current_path).to eq(root_path)
      expect(page).to have_content("Welcome to the Gifs Generator!")
      expect(page).to have_content("Log in")
      expect(page).not_to have_content("Log out")
    end
  end
end
