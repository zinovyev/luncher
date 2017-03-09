module Api
  module V1
    class OrdersController < Api::ApiController
      def index
        orders = Order.list(request.query_parameters[:page] || 1)
        respond_with orders
      end
    end
  end
end
