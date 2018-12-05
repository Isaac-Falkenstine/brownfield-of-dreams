require 'rails_helper'

describe 'GithubService' do
  it "exists" do
    service = GithubService.new

    expect(service).to be_a(GithubService)
  end

  context "instance methods" do
    context "#repos_json" do
      it "returns a array of 5 repos" do
        VCR.use_cassette("github_service_spec") do
          service = GithubService.new

          expect(service.repos_json).to be_a(Array)
          expect(service.repos_json.first).to have_key(:name)
          expect(service.repos_json.first).to have_key(:html_url)
        end
      end
    end
  end
end
