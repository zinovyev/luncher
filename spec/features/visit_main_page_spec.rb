require 'rails_helper'

describe 'visiting the main page' do
  it 'greets the user' do
    visit '/'
    expect(page).to have_current_path(main_page_path)
    expect(page).to have_content 'Welcome'
  end
end
