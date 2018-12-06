require 'rails_helper'

describe UserDashboardFacade do
  describe 'instance methods' do
    it 'can return 5 repos' do
      VCR.use_cassette("user_dash_spec") do
        facade = UserDashboardFacade.new(create(:user))

        expect(facade.repositories.count).to eq(5)
        expect(facade.repositories.first).to be_a(Repository)
      end
    end

    it 'can return users youre following' do
      VCR.use_cassette("user_dash_spec") do
        facade = UserDashboardFacade.new(create(:user))

        expect(facade.following).to be_a(Array)
        expect(facade.following.first).to be_a(GithubUser)
        expect(facade.following.first.name).to eq('jcasimir')
        expect(facade.following.first.url).to eq('https://github.com/jcasimir')
      end
    end
  end
end
