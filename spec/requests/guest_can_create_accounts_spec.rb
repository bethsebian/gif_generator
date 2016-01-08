require 'rails_helper'

RSpec.describe "GuestCanCreateAccounts", type: :request do
  describe "GET /users/new" do
    it "guest can create an general user account" do
      visit new_user_path

      fill_in "Username", with: "user"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
      click_on "Create Account"

      user = User.last

      expect(page).to have_content("Account successfully created")
      expect(page).to have_content("Welcome, user!")
      expect(current_path).to eq(user_path(user))

      expect(user.role).to eq(0)
    end
  end
end
