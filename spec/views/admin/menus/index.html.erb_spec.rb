require 'rails_helper'

RSpec.describe "admin/menus/index", type: :view do
  before(:each) do
    assign(:admin_menus, [
      Admin::Menu.create!(),
      Admin::Menu.create!()
    ])
  end

  it "renders a list of admin/menus" do
    render
  end
end
