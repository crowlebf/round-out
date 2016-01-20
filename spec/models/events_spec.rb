require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:starts_at) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should have_valid(:title).when('Pick up basketball') }
  it { should_not have_valid(:title).when('', nil) }
  it { should have_valid(:starts_at).when('2016-01-20 21:00:00 UTC') }
  it { should_not have_valid(:title).when('', nil) }
  it { should have_valid(:description).when("We're looking to get 4 additional people together to play some basketball") }
  it { should_not have_valid(:description).when('', nil) }
  it { should have_valid(:address).when("Titus Sparrow Park") }
  it { should_not have_valid(:address).when(nil,'') }
  it { should have_valid(:city).when("Boston") }
  it { should_not have_valid(:city).when(nil,'') }
  it { should have_valid(:state).when("MA") }
  it { should_not have_valid(:state).when(nil,'') }
end
