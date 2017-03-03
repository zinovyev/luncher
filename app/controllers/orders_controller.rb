require 'calendar/calendar'

class OrdersController < ApplicationController
  include RequireAdminConcern

  def index
  end

  def new
    @date = Date.parse params[:date]
    @order = get_order(@date)
    @prices = Price.for_today(@date)
    raise ArgumentError, 'No prices available' if @prices.empty?
  rescue ArgumentError
    redirect_to dashboard_path
  end

  def select_price
    order = Order.find(price_to_order_params[:order_id])
    price = Price.find(price_to_order_params[:price_id])
    if order && price
      order.add_course price
      order.save
      redirect_to new_order_path(date: order.created_date)
    else
      flash[:danger] = 'Order Or Price Not Found!'
      redirect_to dashboard_path
    end
  end

  private

  def get_order(date)
    Order.where(
      'DATE(created_at) = :date AND user_id = :user_id',
      date: date, user_id: current_user.id
    ).take || Order.create(user: current_user, created_at: date)
  end

  def price_to_order_params
    @order_params ||= params.permit(:price_id, :order_id)
  end

  def calendar
    @calendar ||= Calendar::Calendar.new
  end
end
