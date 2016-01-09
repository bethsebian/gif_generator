require 'rails_helper'

RSpec.describe "RegisteredUserCanLogins", type: :request do
  describe "GET /login" do
    it "logs in user and brings them to dashboard" do
      user = User.create(username: "user", password: "password")

      visit login_path

      fill_in "Username", with: "user"
      fill_in "Password", with: "password"

      click_on "Log in"

      expect(page).to have_content("Welcome, user!")
      expect(page).to have_content("Successfully Logged In!")
      expect(current_path).to eq(user_path(user))
    end
  end
end
