require 'rails_helper'

describe 'as a user viewing the dashboard' do

  before(:each) do
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(body: File.read("./spec/fixtures/github_repos.json"))
    stub_request(:get, "https://api.github.com/user/followers").
      to_return(body: File.read("./spec/fixtures/github_followers.json"))
    stub_request(:get, "https://api.github.com/user/following").
      to_return(body: File.read("./spec/fixtures/github_following.json"))
  end

  describe 'when I click add friend next to a follower' do
    it 'displays that follower in the friends section' do

      user = create(:user, token: ENV['GITHUB_TOKEN_1'])

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path

      within("ul.followers") do
        click_link("Add Friend", :match => :first)
      end

      within("section.friends") do
        expect(page).to have_css("h1", :text => "Friends")
        expect(page).to have_content("somebodys name")
      end
    end
  end
end