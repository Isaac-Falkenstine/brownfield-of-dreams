require 'rails_helper'

describe 'As a visitor' do
  describe 'when I visit the about page' do
    it 'should display information about the app' do
      visit get_started_path

      expect(page).to have_content("if you are a current student for addition content.")
      expect(page).to have_content("Register to bookmark segments.")
    end
  end
end
