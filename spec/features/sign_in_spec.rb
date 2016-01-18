require "rails_helper"

feature 'user signs in', %{
  As a user
  I want to sign in
  So that I can post new events and join existing events

  Acceptance Criteria
  [] I am authenticated and gain access to the system if I specify valid,
      previously registered email and password.
  [] I remain unathenticated if I specify invalid email/password
  [] I cannot sign in again if I am already signed in
} do

  scenario 'existing user specifies a valid email and password' do
    user = FactoryGirl.create(:user)
    visit root_path
    click_link 'Sign In'
    fill_in "Email", with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    expect(page).to have_content('Welcome back!')
    expect(page).to have_content('Sign Out')
  end

  # scenario 'a nonexistent email and password is supplied' do
  #   visit root_path
  #   click_link 'Sign In'
  #   fill_in 'Email', with: 'anonexistentuser'
  #   fill_in 'Password', with: 'whawhawha'
  #   click_button 'Sign In'
  #   expect(page).to_not have_content('Welcome back!')
  #   expect(page).to_not have_content('Sign Out')
  #   expect(page).to have_content('Invalid email or password')
  # end
  #
  # scenario 'an existing email with wrong password is denied access' do
  #   user = FactoryGirl.create(:user)
  #   visit root_path
  #   click_link 'Sign In'
  #   fill_in 'Email', with: user.email
  #   fill_in 'Password', with: 'incorrectPassword'
  #   click_button 'Sign In'
  #   expect(page).to have_content('Invalid email or password')
  #   expect(page).to_not have_content('Sign Out')
  # end
  #
  # scenario 'an alread authenticated user cannot re-sign in' do
  #   user = FactoryGirl.create(:user)
  #   visit new_user_session_path
  #   fill_in 'Email', with: user.email
  #   fill_in 'Password', with: user.password
  #   click_button 'Sign In'
  #   expect(page).to have_content('Sign Out')
  #   expect(page).to_not have_content('Sign In')
  #   visit new_user_session_path
  #   expect(page).to have_content('You are already signed in.')
  # end
end
