module Admin
  class PricesController < AdminController
    before_action :set_organization, only: [:show, :edit, :create, :update, :destroy]
    before_action :set_price, only: [:show, :edit, :update, :destroy]
    before_action :set_date, only: [:new, :create]

    def new
      @price = Price.new(organization: @organization, date: @date)
    end

    def edit
    end

    def create
      @price = Price.new(price_params)
      @price.organization = @organization
      @price.date = @date

      if @price.save
        redirect_to admin_organization_path(@organization), notice: 'Price was successfully created.'
      else
        render :new
      end
    end

    def update
      if @price.update(price_params)
        redirect_to organization_path(@organization), notice: 'Price was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @price.destroy
      redirect_to admin_organization_path(@organization), notice: 'Price was successfully destroyed.'
    end

    private

    def set_organization
      @organization = Organization.where(id: params[:organization_id], public: true).take
    end

    def set_price
      @price = Price.find(params[:id])
    end

    def set_date
      @date = Date.parse(params[:date])
    end

    def price_params
      params
        .require(:price)
        .permit(:item_id, :value, :item_name)
        .reject! { |p| p == 'item_name' }
    end
  end
end
