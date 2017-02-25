class ItemsController < ApplicationController
  include RequireAdminConcern

  def index
    @items = Item.all
  end
end
