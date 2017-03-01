require 'calendar/calendar'

class OrdersController < ApplicationController
  def index
    @days = calendar.get_number_of_days
  end

  private

  def calendar
    @calendar ||= Calendar::Calendar.new
  end
end
