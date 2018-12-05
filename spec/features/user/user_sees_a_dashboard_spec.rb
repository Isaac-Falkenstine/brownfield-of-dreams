require 'rails_helper'

describe 'User' do
  describe 'on the dashboard page' do

    it 'can see a list of repositories' do

      user = create(:user)
      repo_1 = Repository.new({name: "Repo 1", url: "https://www.google.com"})
      repo_2 = Repository.new({name: "Repo 2", url: "https://www.google.com"})
      repo_3 = Repository.new({name: "Repo 3", url: "https://www.google.com"})
      repo_4 = Repository.new({name: "Repo 4", url: "https://www.google.com"})
      repo_5 = Repository.new({name: "Repo 5", url: "https://www.google.com"})

      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log In"
      visit dashboard_path

      within("section.github") do
        expect(page).to have_css("h1", :text => "GitHub")
        expect(page).to have_css("h2", :text => "Repositories")
        expect(page).to have_content(repo_1.name)
        expect(page).to have_content(repo_5.name)
        expect(page).to have_css('.repository', count: 5)
      end

    end
  end
end
