class Admin::ItemsController < ApplicationController
  before_action :set_admin_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def new
    @admin_item = Admin::Item.new
  end

  def edit
  end

  def create
    @admin_item = Admin::Item.new(admin_item_params)

    respond_to do |format|
      if @admin_item.save
        format.html { redirect_to @admin_item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @admin_item }
      else
        format.html { render :new }
        format.json { render json: @admin_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_item.update(admin_item_params)
        format.html { redirect_to @admin_item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_item }
      else
        format.html { render :edit }
        format.json { render json: @admin_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_item.destroy
    respond_to do |format|
      format.html { redirect_to admin_items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_item
      @admin_item = Admin::Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_item_params
      params.fetch(:admin_item, {})
    end
end
