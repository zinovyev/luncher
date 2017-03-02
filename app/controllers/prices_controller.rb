class PricesController < ApplicationController
  include RequireAdminConcern
  helper AggregateHelper
  
  def index
    @prices = Price.for_today
  end

  def new
    @price = Price.new
  end

  def create
    @price = Price.new(price_params)
    if @price.save
      flash[:success] = 'Price successfully created!'
      redirect_to prices_path
    else
      render :new
    end
  end

  private

  def price_params
    params.require(:price).permit(:value, :item_id)
  end
end
