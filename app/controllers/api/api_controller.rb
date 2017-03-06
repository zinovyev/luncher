module Api
  class ApiController < ActionController::Base
    TOKEN = 'secret'

    before_action :authenticate

    private

    def authenticate
      authenticate_or_request_with_http_token do |token, options|
        ActiveSupport::SecurityUtils.secure_compare(
          ::Digest::SHA256.hexdigest(token),
          ::Digest::SHA256.hexdigest(TOKEN)
        )
      end
    end
  end
end
