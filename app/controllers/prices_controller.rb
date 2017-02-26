class PricesController < ApplicationController
  def index
    @prices = Price.for_today
  end
end
