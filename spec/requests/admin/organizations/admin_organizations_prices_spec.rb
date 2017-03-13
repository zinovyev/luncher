require 'rails_helper'

RSpec.describe "Admin::Organizations::Prices", type: :request do
  describe "GET /admin_organizations_prices" do
    it "works! (now write some real specs)" do
      get admin_organizations_prices_path
      expect(response).to have_http_status(200)
    end
  end
end
