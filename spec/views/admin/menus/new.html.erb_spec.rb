require 'rails_helper'

RSpec.describe "admin/menus/new", type: :view do
  before(:each) do
    assign(:admin_menu, Admin::Menu.new())
  end

  it "renders new admin_menu form" do
    render

    assert_select "form[action=?][method=?]", admin_menus_path, "post" do
    end
  end
end
