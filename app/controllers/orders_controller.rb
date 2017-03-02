require 'calendar/calendar'

class OrdersController < ApplicationController
  include RequireAdminConcern

  def index
    # @days = calendar.get_number_of_days
  end

  def new
    @order = Order.new
    @date = Date.parse params[:date]
    @prices = Price.available_items(@date)
    raise 'No prices available' if @prices.empty? 
  rescue
    redirect_to dashboard_path
  end

  private

  def calendar
    @calendar ||= Calendar::Calendar.new
  end
end
