require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is should be able to be saved with valid attributes' do
    first_user = build(:user)
    expect(first_user.send(:admin_exists?)).to eq false
    expect(first_user.lunches_admin?).to eq false
    first_user.save
    expect(first_user.valid?).to eq true
    expect(first_user.lunches_admin?).to eq true

    second_user = build(:user)
    expect(second_user.send(:admin_exists?)).to eq true 
    expect(second_user.lunches_admin?).to eq false
    second_user.save
    expect(second_user.valid?).to eq true
    expect(second_user.lunches_admin?).to eq false 
  end

  it 'should not pass with wrong paramteres' do
    user = build(:user)
    user.name = nil
    user.username = nil
    user.save
    expect(user.valid?).to eq false
    expect(user.errors.count).to eq 2
  end
end
