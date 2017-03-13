require 'rails_helper'

RSpec.describe "admin/organizations/show", type: :view do
  before(:each) do
    @admin_organization = assign(:admin_organization, Admin::Organizations::Price.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
