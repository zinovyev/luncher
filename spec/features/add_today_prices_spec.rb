require 'rails_helper'
require 'support/devise'

describe 'add today prices process' do
  it 'shows a prices page for today' do
    user = create(:user)
    sign_in user 

    create_list(:item_with_prices, 55, prices_count: 5)
    create_list(:item_with_today_prices, 5, prices_count: 1)

    visit prices_path
  end

  it 'lets me to add new prices for items from menu' do

  end

  it 'lets me to delete or modify a price' do

  end
end
