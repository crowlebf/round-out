require 'rails_helper'

feature "The event add page: ", %{
  As a user
  I want to add a event
  So that I can get other users to view my event

  Acceptance Criteria
  [x] I am authenticated and can access the new event form.
  [X] I cannot access new event form if I am not authenticated
  [x] I can create a new event with valid info
  [x] I cannot create a new event with invalid form info
  [x] I can cancel an event creation
} do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:event) { FactoryGirl.create(:event) }

  before(:each) do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button 'Sign In'
  end

  scenario "authenticated user access new event form" do
    visit events_path
    click_link 'Add Event'
    expect(page).to have_content('New Event')
    expect(page).to have_content('Cancel')
  end

  scenario "authenticated user adds new event successfully" do
    visit new_event_path

    fill_in "Title", with: event.title
    fill_in "Description", with: event.description
    fill_in "form_date", with: "01/05/2016"
    fill_in "form_time", with: "09:00 PM"
    fill_in "Address", with: event.address
    fill_in "City", with: event.city
    fill_in "State", with: event.state
    click_button "Add Event"
    expect(page).to have_content "Event added!"
    expect(page).to have_content event.title
    expect(page).to have_content user.last_name
  end

  scenario "authenticated user inputs incorrect info" do
    visit new_event_path
    click_button "Add Event"

    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "City can't be blank"
  end

  scenario "unauthenticated user cannot see add new event link" do
    click_link 'Sign Out'
    visit events_path
    expect(page).to_not have_content('Add Event')
  end

  scenario "unathenticated user tries to access new event path" do
    click_link 'Sign Out'
    visit new_event_path
    expect(page).to have_content(
    'You need to sign in or sign up before continuing'
      )
    expect(page).to_not have_content('New Event Form')
  end

  scenario "authenticated user cancels new bourbon submission" do
    visit new_event_path
    click_link 'Cancel'
    expect(current_path).to eq events_path
  end
end
