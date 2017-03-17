require 'calendar/calendar'

class UsersController < ApplicationController
  def dashboard
    @calendar = Calendar::Calendar.new(current_user.organization)
    @calendar.paginate(invert_page)
  end

  private

  def invert_page
    page = helpers.current_page
    page > 1 ? (page - 1) * -1 : page
  end
end
