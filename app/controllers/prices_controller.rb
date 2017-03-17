class PricesController < ApplicationController
  include RequireAdminConcern
  helper AggregateHelper

  def index
    @prices = Price.for_today
  end

  private

  def price_params
    params.require(:price).permit(:value, :item_id)
  end
end
