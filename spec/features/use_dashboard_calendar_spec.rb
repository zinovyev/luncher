require 'rails_helper'
require 'support/devise'

describe 'dashboard calendar' do
  let!(:user) do
    create_list(:user, 2)
    user = User.last
    sign_in user
    user
  end

  let!(:items) do
    items = create_list(
      :item_with_date_prices,
      1,
      prices_count: 15,
      prices_date: Date.new(2016, 12, 01)
    )
  end

  before(:each) do
    def Date.today
      Date.new(2017, 1, 1)
    end

    zone = Time.zone
    def zone.today
      Date.today
    end
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

    find(:xpath, '(//input[@type="submit" and @value="Add To Order"])[1]').click()
    expect(page).to have_current_path(new_order_path('2016-12-01'))

    # expect(page).to have_xpath('//tr[contains(@class, "selected-item")]')
  end

  it 'let\'s me to create a new order' do
    # find_link('1').click
  end


  it 'shows me my order on the calendar page'

end


