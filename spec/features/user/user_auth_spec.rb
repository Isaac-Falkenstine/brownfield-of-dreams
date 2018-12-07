require 'rails_helper'

describe 'User' do
  describe 'on the dashboard page' do

    before(:each) do
      stub_request(:get, "https://api.github.com/user/repos").
        to_return(body: File.read("./spec/fixtures/github_repos.json"))
      stub_request(:get, "https://api.github.com/user/followers").
        to_return(body: File.read("./spec/fixtures/github_followers.json"))
      stub_request(:get, "https://api.github.com/user/following").
        to_return(body: File.read("./spec/fixtures/github_following.json"))
    end

    it 'can use github auth' do

      user = create(:user)

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path
      click_on "Connect to Github"

    end
  end
end

# it "can sign in user with Twitter account" do
#   click_link "Sign in"
#   page.should have_content("mockuser")  # user name
#   page.should have_css('img', :src => 'mock_user_thumbnail_url') # user image
#   page.should have_content("Sign out")
# end
#
# it "can handle authentication error" do
#   OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
#   visit '/'
#   page.should have_content("Sign in with Twitter")
#   click_link "Sign in"
#   page.should have_content('Authentication failed.')
# end
