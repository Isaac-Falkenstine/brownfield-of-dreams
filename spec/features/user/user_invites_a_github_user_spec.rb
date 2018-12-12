require 'rails_helper'

describe 'As a registered user' do

  before(:each) do

    stub_request(:get, "https://api.github.com/user/repos").
      to_return(body: File.read("./spec/fixtures/github_repos.json"))
    stub_request(:get, "https://api.github.com/user/followers").
      to_return(body: File.read("./spec/fixtures/github_followers.json"))
    stub_request(:get, "https://api.github.com/user/following").
      to_return(body: File.read("./spec/fixtures/github_following.json"))
    stub_request(:get, "https://api.github.com/users/Isaac-Falkenstine").
      to_return(body: File.read("./spec/fixtures/current_user_github_info.json"))

    user = create(:user, 
                  token: ENV['GITHUB_TOKEN_1'], 
                  github_id: 41242161,
                  github_login: "Isaac-Falkenstine")
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"
  end

  describe 'when I click invite from dashboard' do

    it 'dispays a github handle form' do
      click_on "Send an Invite"

      expect(current_path).to eq(invite_path)
      expect(page).to have_content("Enter a GitHub handle to send an invitation.")
    end
  end

  describe 'when I enter a valid handle and click send invite' do

    before do
      stub_request(:get, "https://api.github.com/users/myfriend").
        to_return(body: File.read("./spec/fixtures/github_friend_with_email.json"))
    end

    it 'displays a success message on the dashboard page' do
      click_on "Send an Invite"

      fill_in "handle", with: "myfriend"
      click_on "Send Invite"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")
    end
  end

  describe 'when I enter an invalid handle and click send invite' do

    before do
      stub_request(:get, "https://api.github.com/users/notmyfriend").
        to_return(body: File.read("./spec/fixtures/github_user_not_found.json"))
    end

    it 'displays an error message on the dashboard page' do
      click_on "Send an Invite"

      fill_in "handle", with: "notmyfriend"
      click_on "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github handle you entered is not valid.")
    end
  end

  describe 'when I enter a user with no associated email' do

    before do
      stub_request(:get, "https://api.github.com/users/myfriendwithnoemail").
        to_return(body: File.read("./spec/fixtures/github_friend_without_email.json"))
    end

    it 'displays an error message on the dashboard page' do
      click_on "Send an Invite"

      fill_in "handle", with: "myfriendwithnoemail"
      click_on "Send Invite"

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
    end
  end

end
