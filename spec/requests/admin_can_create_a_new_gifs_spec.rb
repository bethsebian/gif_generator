require 'rails_helper'

RSpec.describe "AdminCanCreateANewGifs", type: :request do
  describe "GET /new_admin_gif" do
    xit "creates a new gif with a category" do
      admin = User.new(username: 'admin', password: 'password', role: 1)
      # category = Category.new(name: 'kitten')

      ApplicationController.any_instance.stub(:current_user).returns(admin)

      visit new_admin_gif_path

      fill_in "Search term", with: 'kitten'
      submit

      assert gif show page (Needs category)



      # expect(response).to have_http_status(200)
    end
  end
end
