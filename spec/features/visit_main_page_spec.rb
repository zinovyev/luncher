require 'rails_helper'

describe 'visiting the main page' do
  it 'greets the user' do
    visit '/'
    expect(page).to have_current_path(root_path)
    expect(page).to have_content 'Welcome'
  end
end
