require 'rails_helper'
require 'support/devise'

describe 'dashboard calendar' do
  let!(:user) do
    create_list(:user, 2)
    user = User.last
    sign_in user
    user
  end

  it 'it shows me the calendar page' do

  end

  it 'let\'s me to create a new order'
  it 'shows me my order on the calendar page'
end
