require "rails_helper"

feature 'new user signs up', %{
  As a prospective user
  I want to sign up
  So that I can gain access in order to create new events or join existing
  events

  Acceptance Criteria
  [x] I will create an account from sign up page
  [x] I must specify a valid username
  [x] I must specify a valid e-mail
  [x] I must specify a password and confirm that password
  [x] I get error messages if I do not perform the above
  [x] I register my account and am authenticated if I specify valid information

} do
  scenario "prospective user gets to sign up page from root path" do
    visit root_path
    click_on "Sign In"
    expect(page).to have_content("Sign In")
    click_on "Sign up"
    expect(page).to have_content("Password confirmation")
  end

  scenario "prospective user correctly submits sign up form" do
    visit new_user_registration_path
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Email', with: 'john@smith.com'
    fill_in 'Password', with: 'johnsmith'
    fill_in 'Password confirmation', with: 'johnsmith'
    click_on 'Sign Up'
    expect(page).to have_content('Welcome! You have signed up successfully')
    expect(page).to have_content('John')
  end

  scenario 'required information is not supplied' do
    visit new_user_registration_path
    click_on 'Sign Up'
    expect(page).to have_content("can't be blank")
    expect(page).to have_content('Sign In')
  end

  scenario 'password does not match confirmation' do
    visit new_user_registration_path
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'morepassword'
    click_button 'Sign Up'
    expect(page).to have_content("doesn't match")
    expect(page).to have_content('Sign In')
  end
end
