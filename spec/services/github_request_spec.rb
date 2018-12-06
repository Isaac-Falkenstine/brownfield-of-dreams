require 'rails_helper'

describe 'GithubService' do
  it "exists" do
    service = GithubService.new(ENV["GITHUB_TOKEN_1"])

    expect(service).to be_a(GithubService)
  end

  context "instance methods" do
    context "#repos_json" do
      it "returns a array of 5 repos" do
        VCR.use_cassette("github_service_spec", record: :all) do
          user_1 = create(:user, token: ENV["GITHUB_TOKEN_1"])
          service_1 = GithubService.new(user_1.token)

          expect(service_1.repos_json).to be_a(Array)
          expect(service_1.repos_json.first).to have_key(:name)
          expect(service_1.repos_json.first).to have_key(:html_url)
          expect(service_1.repos_json.first[:name]).to eq("activerecord-obstacle-course")
          expect(service_1.repos_json.first[:html_url]).to eq("https://github.com/Isaac-Falkenstine/activerecord-obstacle-course")

          user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
          service_2 = GithubService.new(user_2.token)

          expect(service_2.repos_json).to be_a(Array)
          expect(service_2.repos_json.first).to have_key(:name)
          expect(service_2.repos_json.first).to have_key(:html_url)
          expect(service_2.repos_json.first[:name]).to eq("movie-tracker2")
          expect(service_2.repos_json.first[:html_url]).to eq("https://github.com/amy-r/movie-tracker2")
        end
      end
    end

    context "#followers_json" do
      it "returns a array of all followers" do
        VCR.use_cassette("github_followers_service_spec", record: :all) do
          user_1 = create(:user, token: ENV["GITHUB_TOKEN_1"])
          service_1 = GithubService.new(user_1.token)

          expect(service_1.followers_json).to be_a(Array)
          expect(service_1.followers_json.first).to have_key(:login)
          expect(service_1.followers_json.first).to have_key(:html_url)
          expect(service_1.followers_json.first[:login]).to eq("averimj")
          expect(service_1.followers_json.first[:html_url]).to eq("https://github.com/averimj")

          user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
          service_2 = GithubService.new(user_2.token)

          expect(service_2.followers_json).to be_a(Array)
          expect(service_2.followers_json.first).to have_key(:login)
          expect(service_2.followers_json.first).to have_key(:html_url)
          expect(service_2.followers_json.first[:login]).to eq("chunktooth")
          expect(service_2.followers_json.first[:html_url]).to eq("https://github.com/chunktooth")
        end
      end
    end

    context "#following_json" do
      it "returns the users this user is following" do
        VCR.use_cassette("github_service_spec", record: :all) do
          user_1 = create(:user, token: ENV["GITHUB_TOKEN_1"])
          service_1 = GithubService.new(user_1.token)

          expect(service_1.following_json).to be_a(Array)
          expect(service_1.following_json.first).to have_key(:login)
          expect(service_1.following_json.first).to have_key(:html_url)
          expect(service_1.following_json.first[:login]).to eq("jcasimir")
          expect(service_1.following_json.first[:html_url]).to eq("https://github.com/jcasimir")

          user_2 = create(:user, token: ENV["GITHUB_TOKEN_2"])
          service_2 = GithubService.new(user_2.token)

          expect(service_2.following_json).to be_a(Array)
          expect(service_2.following_json.first).to have_key(:login)
          expect(service_2.following_json.first).to have_key(:html_url)
          expect(service_2.following_json.first[:login]).to eq("iandouglas")
          expect(service_2.following_json.first[:html_url]).to eq("https://github.com/iandouglas")
        end
      end
    end

  end
end
