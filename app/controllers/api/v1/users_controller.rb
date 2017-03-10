module Api
  module V1
    class UsersController < Api::ApiController
      def show
        user = User.find(params[:id])
        respond_with user
      end
    end
  end
end
