class ItemsController < ApplicationController
  include RequireAdminConcern

  def index
    @items = Item.all
  end

  def new

  end
end
