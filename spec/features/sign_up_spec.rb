require 'rails_helper'

describe 'the sign up process' do
  it 'signs me up' do
    visit root_path
    find_link(id: 'sign_up_main').click

    expect(page).to have_path('/sign_up')

    session = Capybara::Session.new
    session.within('form#users') do
      session.fill_in 'Name', with: 'John'
      session.fill_in 'Login', with: 'johnsmith'
      session.fill_in 'Email', with: 'john@smith.com'
      session.fill_in 'Password', with: 'password'
    end
    session.click_on 'Sign Up'

    expect(page).to have_path(user_path(session.user))
    expect(page).to have_content('Hello, John')
  end
end
