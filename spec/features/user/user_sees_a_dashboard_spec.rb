require 'rails_helper'

describe 'User' do
  describe 'on the dashboard page' do

    it 'can see a list of repositories' do
      stub_request(:get, "https://api.github.com/user/repos").
        to_return(body: File.read("./spec/fixtures/github_repos.json"))

      user = create(:user)

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
  end
end
