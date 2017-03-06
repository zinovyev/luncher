module Api
  module V1
    class OrdersController < Api::ApiController
      def index
        render json: { text: 'Hello World!' }
      end
    end
  end
end
