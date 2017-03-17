require 'calendar/calendar'

class OrdersController < ApplicationController
  include RequireAdminConcern

  before_action :require_admin, only: [:index]

  def new
    @date = Date.parse params[:date]
    @order = get_order(@date)
    @prices = Price.for_today(@date)
    raise ArgumentError, 'No prices available' if @prices.empty?
  rescue ArgumentError
    redirect_to dashboard_path
  end

  def select_price
    price = Price.find select_price_params[:price_id]
    @order = get_order Date.parse params[:date]
    @order.add_course price
    flash[:danger] = 'Could not save the order!' unless @order.save

    redirect_to new_order_path @order.created_date
  end

  private

  def get_order(date)
    Order.where(
      'DATE(created_at) = :date AND user_id = :user_id',
      date: date, user_id: current_user.id
    ).eager_load(:main_course, :first_course, :drink).first ||
      Order.create(user: current_user, created_at: date)
  end

  def select_price_params
    @order_params ||= params.permit(:price_id, :order_id)
  end

  def calendar
    @calendar ||= Calendar::Calendar.new
  end
end
