require 'calendar/calendar'

class UsersController < ApplicationController
  def dashboard
    @calendar = Calendar::Calendar.new
    @calendar.paginate(helpers.current_page)
  end
end
