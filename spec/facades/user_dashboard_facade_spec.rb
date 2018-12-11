require 'rails_helper'

describe UserDashboardFacade do
  describe 'instance methods' do
    it 'can return 5 repos' do
      VCR.use_cassette("user_dash_spec", record: :all) do
        facade = UserDashboardFacade.new(create(:user, token: ENV['GITHUB_TOKEN_1']))

        expect(facade.repositories).to be_a(Array)
        expect(facade.repositories.count).to eq(5)
        expect(facade.repositories.first).to be_a(Repository)
        expect(facade.repositories.first.name).to eq("activerecord-obstacle-course")
        expect(facade.repositories.first.url).to eq("https://github.com/Isaac-Falkenstine/activerecord-obstacle-course")
      end
    end

    it 'can return all followers' do
      VCR.use_cassette("user_dash_spec", record: :all) do
        facade = UserDashboardFacade.new(create(:user, token: ENV['GITHUB_TOKEN_1']))

        expect(facade.followers).to be_a(Array)
        expect(facade.followers.first).to be_a(GithubUser)
        expect(facade.followers.first.login).to eq("averimj")
        expect(facade.followers.first.url).to eq("https://github.com/averimj")
      end
    end

    it 'can return users youre following' do
      VCR.use_cassette("user_dash_spec", record: :all) do
        facade = UserDashboardFacade.new(create(:user, token: ENV['GITHUB_TOKEN_1']))

        expect(facade.following).to be_a(Array)
        expect(facade.following.first).to be_a(GithubUser)
        expect(facade.following.first.login).to eq('jcasimir')
        expect(facade.following.first.url).to eq('https://github.com/jcasimir')
      end
    end

    it 'can return all friended users' do
      VCR.use_cassette("user_dash_spec", record: :all) do
        user = create(:user)
        friend = create(:user)
        facade = UserDashboardFacade.new(user)
        Friendship.create(follower: user, followed: friend)

        expect(facade.friends).to be_a(Array)
        expect(facade.friends.first).to be_a(User)
        expect(facade.friends.first.first_name).to eq(friend.first_name)
        expect(facade.friends.first.last_name).to eq(friend.last_name)
      end
    end
  end
end
