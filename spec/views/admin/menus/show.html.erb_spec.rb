require 'rails_helper'

RSpec.describe "admin/menus/show", type: :view do
  before(:each) do
    @admin_menu = assign(:admin_menu, Admin::Menu.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
