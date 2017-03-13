require 'rails_helper'

RSpec.describe "admin/organizations/index", type: :view do
  before(:each) do
    assign(:admin_organizations_prices, [
      Admin::Organizations::Price.create!(),
      Admin::Organizations::Price.create!()
    ])
  end

  it "renders a list of admin/organizations" do
    render
  end
end
