require 'rails_helper'

describe "as I visitor or user viewing the tutorial show page" do
  context 'no videos for current tutorial' do
    it 'should display the show page with no videos' do
      tutorial = create(:tutorial)
      visit root_path
      click_on "#{tutorial.title}"

      expect(current_path).to eq(tutorial_path(tutorial))
      expect(page).to have_content(tutorial.title)
      expect(page).to have_content("There are no videos for this tutorial.")
    end
  end
end