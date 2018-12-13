require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the about page' do
    it 'should display information about the app' do
      visit about_path

      expect(page).to have_content("Turing Tutorials")
      expect(page).to have_content("This application is designed to")
    end
  end
end