require 'rails_helper'

describe 'User' do
  describe 'on the dashboard page' do

    it 'can see a list of repositories' do      user = create(:user)
      stub_request(:get, "https://api.github.com/user/repos").
        to_return(body: File.read("./spec/fixtures/github_repos.json"))

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

    it 'can see a list of users theyre following' do
      user = create(:user)

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path

      within("section.github") do
        expect(page).to have_css("h1", :text => "GitHub")
        expect(page).to have_css("h2", :text => "Following")
        expect(page).to have_content("jcasimir")
        expect(page).to have_content("Diazblack")
        expect(page).to have_css('.following', count: 18)


    it 'wont see repos without a key' do
      VCR.use_cassette("user_login_spec") do
        user = create(:user)

        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log In"
        visit dashboard_path

        expect(page).to_not have_css("h1", :text => "GitHub")
        expect(page).to_not have_css("h2", :text => "Repositories")
        expect(page).to_not have_content("activerecord-obstacle-course")
        expect(page).to_not have_content("apollo_14")
        expect(page).to_not have_css('.repository', count: 5)
      end
    end
  end
end
