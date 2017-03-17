require 'rails_helper'
require 'support/devise'

describe 'orders page in admin panel' do
  it 'show orders page' do
    user = create(:user)
    sign_in user

    visit admin_orders_path
  end
end
