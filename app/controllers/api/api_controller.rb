module Api
  class ApiController < ActionController::Base
    respond_to :json
    before_filter :restrict_access

    private

    def restrict_access
      # binding.pry
      authenticate_or_request_with_http_token do |token, options|
        ApiKey.exists? access_token: token
      end
    end
  end
end
