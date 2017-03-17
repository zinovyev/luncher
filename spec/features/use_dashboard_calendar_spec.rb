require 'rails_helper'
require 'support/devise'

describe 'dashboard calendar' do
  let!(:user) do
    create_list(:user, 2)
    user = User.last
    user.approved = true
    user.save
    sign_in user
    user
  end

  let!(:items) do
    items1 = create_list(
      :item_with_date_prices,
      5,
      course: Item::FIRST_COURSE,
      prices_count: 1,
      prices_date: Date.new(2016, 12, 1)
    )

    items2 = create_list(
      :item_with_date_prices,
      5,
      course: Item::MAIN_COURSE,
      prices_count: 1,
      prices_date: Date.new(2016, 12, 1)
    )
    items3 = create_list(
      :item_with_date_prices,
      5,
      course: Item::DRINK,
      prices_count: 1,
      prices_date: Date.new(2016, 12, 1)
    )
    items1 + items2 + items3
  end

  before(:each) do
    # rubocop:disable Rails/Date
    def Date.today
      Date.new(2017, 1, 1)
    end

    zone = Time.zone
    def zone.today
      Date.today
    end
    # rubocop:enable Rails/Date
  end

  it 'it shows me the calendar page' do
    visit root_path
    expect(page).to have_current_path(dashboard_path)

    expect(page).to have_content('2017 Jan')
    expect(page).to have_selector('table.dashboard-calendar')

    find_link('Prev').click
    expect(page).to have_content('2016 Dec')
    expect(page).to have_xpath('//table/tbody/tr[1]/td[5]/a[@href="/dashboard/2016-12-01/new"]')

    find_link('1').click
    expect(page).to have_current_path(new_order_path('2016-12-01'))

    button_selector = '//input[@type="submit" and @value="Add To Order"]'
    expect(page).to have_selector(:xpath, button_selector, count: 15)

    find(:xpath, "(#{button_selector})[2]").click
    expect(page).to have_current_path(new_order_path('2016-12-01'))
    find(:xpath, "(#{button_selector})[6]").click
    expect(page).to have_current_path(new_order_path('2016-12-01'))
    find(:xpath, "(#{button_selector})[14]").click
    expect(page).to have_current_path(new_order_path('2016-12-01'))

    expect(page).to have_selector(
      :xpath,
      "#{button_selector}/ancestor::tr[contains(@class, 'info')]",
      count: 3
    )

    order_summary = format('%.2f', (
      items[1].prices.first.value +
      items[5].prices.first.value +
      items[13].prices.first.value
    ).to_s)
    expect(page).to have_content("(#{order_summary})")

    find_link('Back').click
    expect(page).to have_current_path(dashboard_path)
  end
end
