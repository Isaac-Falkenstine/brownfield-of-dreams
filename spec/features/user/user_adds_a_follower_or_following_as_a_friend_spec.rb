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

  context 'dashboard followers' do

    it 'should display an Add Friend link to followers that are users' do

      user_1 = create(:user, token: ENV['GITHUB_TOKEN_1'])
      user_2 = create(:user, github_id: 33760591)

      visit login_path
      fill_in "Email", with: user_1.email
      fill_in "Password", with: user_1.password
      click_button "Log In"
      visit dashboard_path

      within("ul.followers") do
        expect(page).to have_css("a.add-friend", count: 1)
        within all("li.follower").first do
          expect(page).to have_css("a.add-friend")
        end
        within all("li.follower").last do
          expect(page).not_to have_css("a.add-friend")
        end
      end

    end

    describe 'when I click add friend next to a follower' do
      it 'displays that follower in the friends section' do

        user_1 = create(:user, token: ENV['GITHUB_TOKEN_1'])
        user_2 = create(:user, github_id: 33760591)

        visit login_path
        fill_in "Email", with: user_1.email
        fill_in "Password", with: user_1.password
        click_button "Log In"
        visit dashboard_path

        within("ul.followers") do
          click_link("Add Friend", :match => :first)
        end

        within("section.friends") do
          expect(page).to have_css("h1", :text => "Friends")
          expect(page).to have_content(user_2.first_name)
          expect(page).to have_content(user_2.last_name)
        end
      end
    end
  end

  context 'dashboard following' do

    it 'should display an Add Friend link to following that are users' do

      user_1 = create(:user, token: ENV['GITHUB_TOKEN_1'])
      user_2 = create(:user, github_id: 43102)

      visit login_path
      fill_in "Email", with: user_1.email
      fill_in "Password", with: user_1.password
      click_button "Log In"
      visit dashboard_path

      within("ul.followings") do
        expect(page).to have_css("a.add-friend", count: 1)
        within all("li.following").first do
          expect(page).to have_css("a.add-friend")
        end
        within all("li.following").last do
          expect(page).not_to have_css("a.add-friend")
        end
      end

    end

    describe 'when I click add friend next to a follower' do
      it 'displays that follower in the friends section' do

        user_1 = create(:user, token: ENV['GITHUB_TOKEN_1'])
        user_2 = create(:user, github_id: 43102)

        visit login_path
        fill_in "Email", with: user_1.email
        fill_in "Password", with: user_1.password
        click_button "Log In"
        visit dashboard_path

        within("ul.followings") do
          click_link("Add Friend", :match => :first)
        end

        within("section.friends") do
          expect(page).to have_css("h1", :text => "Friends")
          expect(page).to have_content(user_2.first_name)
          expect(page).to have_content(user_2.last_name)
        end
      end
    end
  end

end