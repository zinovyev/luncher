require 'rails_helper'
require 'support/devise'

describe 'add today prices process' do
  it 'shows a prices page for today' do
    user = create(:user)
    sign_in user

    create_list(:item_with_prices, 55, prices_count: 5)
    create_list(:item_with_today_prices, 5, prices_count: 1)

    visit prices_path
    expect(page).to have_current_path(prices_path)
    expect(page).to have_content('Today Menu')
    page.assert_selector('.price-row', count: 5)
  end

  it 'lets me delete or modify a price' do
    user = create(:user)
    sign_in user

    items = create_list(:item_with_prices, 55, prices_count: 5)
    price = build(:price)

    visit prices_path
    find_link('Add New Price').click

    expect(page).to have_current_path(new_price_path)
    expect(page).to have_content('New Price')

    within('form#new_price') do
      select items.first.title, from: 'Item'
      fill_in 'Value', with: price.value
    end
    click_on 'Create Price'

    expect(page).to have_current_path(prices_path)
    expect(page).to have_content('Price successfully created')
    page.assert_selector('.price-row', count: 1)
  end
end
