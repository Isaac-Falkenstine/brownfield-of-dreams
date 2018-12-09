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

    it 'can see a list of repositories' do

      user = create(:user, token: ENV['GITHUB_TOKEN_1'])

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path

      within("section.github") do
        expect(page).to have_css("h1", :text => "GitHub")
        expect(page).to have_css("h2", :text => "Repositories")
        expect(page).to have_content("activerecord-obstacle-course")
        expect(page).to have_content("apollo_14")
        expect(page).to have_css('.repository', count: 5)
      end
    end

    it 'can see a list of followers' do

      user = create(:user, token: ENV['GITHUB_TOKEN_1'])

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path

      within("section.github") do
        expect(page).to have_css("h1", :text => "GitHub")
        expect(page).to have_css("h2", :text => "Followers")
        expect(page).to have_content("averimj")
        expect(page).to have_content("MaryBork")
        expect(page).to have_css('.follower')
      end
    end

    it 'can see a list of users theyre following' do

      user = create(:user, token: ENV['GITHUB_TOKEN_1'])

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path

      within("section.github") do
        expect(page).to have_css("h2", :text => "Following")
        expect(page).to have_content("jcasimir")
        expect(page).to have_content("Diazblack")
        expect(page).to have_css('.following', count: 18)
      end
    end

    it 'wont see GitHub section without a key' do

      user = create(:user)

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path

      expect(page).to_not have_css("h1", :text => "GitHub")
      expect(page).to_not have_css("h2", :text => "Repositories")
      expect(page).to_not have_css("h2", :text => "Followers")
      expect(page).to_not have_css("h2", :text => "Following")
      expect(page).to_not have_content("activerecord-obstacle-course")
      expect(page).to_not have_content("apollo_14")
      expect(page).to_not have_content("averymj")
      expect(page).to_not have_content("MaryBork")
      expect(page).to_not have_content("jcasimir")
      expect(page).to_not have_content("Diazblack")
      expect(page).to_not have_css('.repository')
      expect(page).to_not have_css('.follower')
      expect(page).to_not have_css('.following')
    end
  end
  it 'can bookmark videos' do

    user = create(:user)
    video = create(:video)
    tutorial = video.tutorial

    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log In"

    visit tutorial_path(tutorial)
    click_on "Bookmark"

    visit dashboard_path

    expect(page).to have_css("h1", :text => "Bookmarked Segments")
    expect(page).to have_content(video.title)

    click_on video.title

    expect(current_path).to eq(tutorial_path(tutorial))
  end
end
