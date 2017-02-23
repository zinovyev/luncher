require 'rails_helper'

describe 'the sign up process' do
  it 'signs me up' do
    visit root_path
    find_link(id: 'sign_up_main').click

    expect(page).to have_current_path('/user/sign_up')

    # session = Capybara::Session.new
    within('form#new_user') do
      fill_in 'Name', with: 'John'
      fill_in 'Login', with: 'johnsmith'
      fill_in 'Email', with: 'john@smith.com'
      fill_in 'Password', with: 'password'
    end
    click_on 'Sign Up'

    expect(page).to have_path(user_path(current_user))
    expect(page).to have_content('Hello, John')
  end
end
