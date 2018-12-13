require 'rails_helper'

describe 'vistor can create an account', :js do

  it ' visits the home page' do
    VCR.use_cassette("vist_home_page_spec") do
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit '/'

      click_on 'Sign In'

      expect(current_path).to eq(login_path)

      click_on 'Sign up now.'

      expect(current_path).to eq(new_user_path)

      fill_in 'user[email]', with: email
      fill_in 'user[first_name]', with: first_name
      fill_in 'user[last_name]', with: last_name
      fill_in 'user[password]', with: password
      fill_in 'user[password_confirmation]', with: password

      click_on'Create Account'

      expect(current_path).to eq(dashboard_path)

      expect(page).to have_content(email)
      expect(page).to have_content(first_name)
      expect(page).to have_content(last_name)
      expect(page).to_not have_content('Sign In')
    end
  end

  pending 'does not create accounts with duplicate emails' do
    VCR.use_cassette("vist_home_page_spec") do
      existing_user = create(:user, email: 'jimbob@aol.com')
      email = 'jimbob@aol.com'
      first_name = 'Jim'
      last_name = 'Bob'
      password = 'password'

      visit '/'
      click_on 'Register'

      expect(current_path).to eq(new_user_path)
      expect(page).to have_content("Username already exists")
    end
      
  it 'gets a flash when making a account' do
    VCR.use_cassette("email_flash_spec") do
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

      click_on'Create Account'

      expect(page).to have_content("This account has not yet been activated. Please check your email.")
      expect(page).to have_content("Logged in as #{first_name} #{last_name}")
      expect(page).to have_content("Status: Inactive")
    end
  end
end
