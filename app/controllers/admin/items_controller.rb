module Admin
  class ItemsController < AdminController
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    autocomplete :item, :title, full: true

    def index
      @items = Item.paginate(page: params[:page], per_page: 10)
    end

    def show
    end

    def new
      @item = Item.new
    end

    def edit
    end

    def create
      @item = Item.new(item_params)
      if @admin_item.save
        redirect_to @admin_item, notice: 'Item was successfully created.'
      else
        render :new
      end
    end

    def update
      if @admin_item.update(admin_item_params)
        redirect_to @admin_item, notice: 'Item was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @item.destroy
      redirect_to admin_items_path, notice: 'Item was successfully destroyed.'
    end

    private

    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.fetch(:admin_item, {})
    end
  end
end
