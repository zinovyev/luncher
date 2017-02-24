require 'rails_helper'

describe 'the sign up process' do
  it 'signs me up' do
    visit root_path
    find_link(id: 'sign_up_main').click

    expect(page).to have_current_path('/user/sign_up')

    user = attributes_for(:user)
    within('form#new_user') do
      fill_in 'Name', with: user[:name]
      fill_in 'Username', with: user[:name]
      fill_in 'Email', with: user[:email] 
      fill_in 'Password', with: user[:password] 
    end
    click_on 'Sign Up'

    expect(current_path).to match(/\/users\/\d+/)
    expect(page).to have_content('Hello, John')
  end
end
