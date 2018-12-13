require 'rails_helper'

describe 'As a user that has received an email confirmation' do
  describe 'when I click on a valid confirmation link' do
    it 'should confirm that I have been verified' do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit new_user_path

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on 'Create Account'

      visit user_activate_url(User.first.status_token)

      expect(User.first.status).to eq("Active")
      expect(page).to have_content("Your account has been activated.")
      expect(current_path).to eq(root_path)
    end

    it 'should throw an error if I do not have a valid status token' do
      user = create(:user)

      visit user_activate_url("NotAValidStatusToken")

      expect(User.first.status).to eq("Inactive")
      expect(page).to have_content("Sorry. User does not exist")
      expect(current_path).to eq(root_path)
    end

  end
end