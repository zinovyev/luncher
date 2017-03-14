module Admin
  class OrdersController < AdminController
    def index
      @orders = Order.paginate(page: params[:page], per_page: 10)
    end
  end
end
