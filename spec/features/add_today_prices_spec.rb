require 'rails_helper'
require 'support/devise'

describe 'add today prices process' do
  it 'shows a prices page for today' do
    user = create(:user)
    sign_in user

    organization = Organization.common.first
    create_list(:item_with_prices,
                55,
                prices_count: 5,
                prices_organization: organization)
    create_list(:item_with_today_prices,
                5,
                prices_count: 1,
                prices_organization: organization)

    visit admin_organization_path(organization)
    expect(page).to have_current_path(admin_organization_path(organization))
    expect(page).to have_content(organization.title)
    page.assert_selector('.price-cell')
  end

  it 'lets me delete or modify a price' do
    user = create(:user)
    sign_in user

    items = create_list(:item_with_prices, 55, prices_count: 5)
    price = build(:price)

    visit admin_organizations_path
    expect(page).to have_current_path(admin_organizations_path)

    button_selector = '//a[contains(text(), "Weekly Menu")]'
    expect(page).to have_selector(:xpath, button_selector, count: 3)
    find(:xpath, "(#{button_selector})[1]").click

    expect(page).to have_current_path(admin_organization_path(2))
    button_selector = '//a[contains(text(), "New Price")]'
    expect(page).to have_selector(:xpath, button_selector, count: 7)
    find(:xpath, "(#{button_selector})[1]").click

    sample_item = items.sample
    find(
      :xpath,
      '//input[contains(@id, "price_item_id")]',
      visible: false
    ).set sample_item.id
    within('form#new_price') do
      fill_in 'Value', with: price.value
    end
    click_on 'Create Price'

    expect(page).to have_current_path(admin_organization_path(2))
    expect(page).to have_content('Price was successfully created')

    expect(page).to have_selector(
      :xpath,
      "//b[contains(text(), '#{sample_item.title}')]",
      count: 1
    )
  end
end
