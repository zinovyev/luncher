class ItemsController < ApplicationController
  include RequireAdminConcern

  before_action :convert_course, only: :create

  def index
    @items = Item.paginate(page: params[:page], per_page: 10)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = 'Item successfully created!'
      redirect_to items_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :photo, :course, :image)
  end

  def convert_course
    params[:item][:course] = params[:item][:course].to_i
  end
end
