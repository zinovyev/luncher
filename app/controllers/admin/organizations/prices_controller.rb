class Admin::Organizations::PricesController < ApplicationController
  before_action :set_price, :set_organization, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @price = Price.new(organization: @organization)
  end

  def edit
  end

  def create
    @price = Price.new(organizations_price_params)

    if @price.save
      redirect_to @admin_organizations_price, notice: 'Price was successfully created.'
    else
      render :new
    end
  end

  def update
      if @price.update(organizations_price_params)
        redirect_to organization_path(@organization), notice: 'Price was successfully updated.'
      else
        render :edit
      end
    end
  end

  def destroy
    @price.destroy
    redirect_to admin_organizations_prices_url, notice: 'Price was successfully destroyed.'
  end

  private

  def set_organization
    @organization = Organization.where(id: params[:organization_id], public: true).first
  end

  def set_price
    @price = Price.find(params[:id])
  end

  def organizations_price_params
    params.fetch(:organizations_price, {})
  end
end
