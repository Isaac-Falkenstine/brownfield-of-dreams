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
  end
end
