require 'rails_helper'

describe 'As an admin' do

  before(:each) do
    admin = create(:user, role: :admin)
    visit login_path
    fill_in "Email", with: admin.email
    fill_in "Password", with: admin.password
    click_button "Log In"
  end

  describe 'when I click new tutorial from the admin dashboard' do

    before(:each) do
      visit admin_dashboard_path
    end

    it 'displays a new tutorial form' do
      click_on "New Tutorial"

      expect(current_path).to eq(new_admin_tutorial_path)
      expect(page).to have_content("New Tutorial")
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_content("Thumbnail")
    end

    it 'creates a new tutorial when I complete the form and click save' do
      click_on "New Tutorial"

      fill_in "tutorial_title", with: "Mod 7"
      fill_in "tutorial_description", with: "So you want to be a 14er?"
      fill_in "tutorial_thumbnail", with: "http://example.com/why.jpg"

      click_button "Save"
      
      expect(current_path).to eq(admin_dashboard_path)
      expect(page).to have_content("Tutorial successfully created.")
      expect(page).to have_content("Mod 7")
    end

    pending 'throws an error when I do not provide a title' do
      click_on "New Tutorial"

      fill_in "tutorial_description", with: "So you want to be a 14er?"
      fill_in "tutorial_thumbnail", with: "http://example.com/why.jpg"

      click_button "Save"
      
      expect(current_path).to eq(new_admin_tutorial_path)
      expect(page).to have_content("Tutorial could not be created.")
    end

  end
end