require 'rails_helper'
require 'support/devise'

describe 'the sign up process' do
  it 'signs me up when data is correct' do
    visit root_path
    find_link('Sign Up').click

    expect(page).to have_current_path(new_user_registration_path)

    user = attributes_for(:user)
    within('form#new_user') do
      fill_in 'Name', with: user[:name]
      fill_in 'Username', with: user[:name]
      fill_in 'Email', with: user[:email]
      fill_in 'Password', with: user[:password]
      fill_in 'Password confirmation', with: user[:password]
    end
    click_on 'Sign Up'

    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content("Hello, #{user[:name]}")
  end
end

describe 'the login in process' do
  it 'signs me in if the user exists' do
    user = create(:user)

    visit root_path
    expect(page).to have_no_content("Logged in as #{user.username}")
    find_link('Log In').click

    expect(page).to have_current_path(new_user_session_path)

    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_on 'Log In'

    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content("Hello, #{user.name}")
  end
end

describe 'log out action' do
  it 'signs me out if the user is logged in' do
    user = create(:user)
    sign_in user

    visit root_path
    expect(page).to have_current_path(dashboard_path)
    expect(page).to have_content("Logged in as #{user.username}")
    find_link('log out').click

    expect(page).to have_current_path(root_path)
    expect(page).to have_no_content("Logged in as #{user.username}")
  end
end
