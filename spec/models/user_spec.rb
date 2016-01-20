require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_valid(:first_name).when('Tim') }
  it { should_not have_valid(:first_name).when('', nil) }
  it { should have_valid(:last_name).when('Williams') }
  it { should_not have_valid(:last_name).when('', nil) }
  it { should have_valid(:email).when('timwilliams@example.com', 'person@example.com') }
  it { should_not have_valid(:email).when('', nil, 'test@', 'test', 'test.com') }

  it 'has matching password and password confirmation' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'differentpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end
