require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user.send(:admin_exists)).to eq false
  end

  it 'should become an admin if no admin yet exists'
end
