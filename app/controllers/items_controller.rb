class ItemsController < ApplicationController
  include RequireAdminConcern

  before_action :convert_course, only: :create

  def index
    @items = Item.paginate(page: params[:page], per_page: 10)
  end

  private

  def convert_course
    params[:item][:course] = params[:item][:course].to_i
  end
end
