class PricesController < ApplicationController
  def index
    @prices = Price.for_today
  end

  def new
    @price = Price.new
  end
end
