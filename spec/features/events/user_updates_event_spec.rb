require 'rails_helper'

feature "The event edit page: ", %{
  As an authenticated user
  I want to edit an existing event I created
  So that I can update the information

  Acceptance Criteria
  [x] I am authenticated and I can access an update page to edit my
      event.
  [x] I see errors if update form is invalid
} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:user2) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event, user: user) }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Sign In'
    visit event_path(event)
  end

  scenario "only event creator can see the edit page" do
    expect(page).to have_link "Update Event"

    click_link "Update Event"
    expect(page).to have_content "Update Event"

    click_link 'Sign Out'
    visit event_path(event)
    expect(page).not_to have_link "Update Event"

    visit new_user_session_path
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_button 'Sign In'

    visit event_path(event)
    expect(page).not_to have_link "Update Event"

    visit edit_event_path(event)
    expect(page).to have_content "You don't have access to this form"
  end

  scenario "creator validly edits the event" do
    expect(page).to have_content event.title

    click_link "Update Event"

    fill_in "Title", with: "Chess Club"
    click_button "Update Event"

    expect(page).to have_content "Event updated successfully"
    expect(page).to have_content "Chess Club"
  end

  scenario "creator invalidly edits event" do
    visit edit_event_path(event)

    fill_in "Title", with: ""
    fill_in "City", with: ""
    click_button "Update Event"

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "City can't be blank"
  end
end
