require 'rails_helper'

RSpec.describe "admin/orders/index", type: :view do
  before(:each) do
    assign(:admin_orders, [
      Admin::Order.create!(),
      Admin::Order.create!()
    ])
  end

  it "renders a list of admin/orders" do
    render
  end
end
