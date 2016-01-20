require "rails_helper"

feature 'user deletes self', %{

  As an authenticated user
  I want to delete my account
  So that my information is deleted from the database

  Acceptance Criteria
  [x] I can delete my account
  [x] I can no longer sign in after deleting my account

} do

  let!(:user) { FactoryGirl.create(:user) }

  before :each do
    visit root_path
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    click_on 'Settings'
  end

  scenario "authenticated user deletes their account" do
    click_on "Delete my account"
    expect(page).to have_content('Bye! Your account has been successfully
    cancelled.')
  end

  scenario 'User cannot login after account deleted' do
    click_on 'Delete my account'
    click_link 'Sign In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    expect(page).to have_content('Invalid email or password')
  end
end
