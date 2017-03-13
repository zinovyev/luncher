module Admin
  class OrganizationsController < ApplicationController
    before_action :set_organization, only: [:show, :edit, :update, :destroy]

    def index
      @organizations = Organization.list_public.paginate(page: params[:page], per_page: 10)
    end

    def show
      @weekly_menu = Price.weekly_menu(@organization)
    end

    def new
      @organization = Organization.new(public: true)
    end

    def edit
    end

    def create
      @organization = Organization.new(organization_params)
      if @organization.save
        redirect_to admin_organizations_path, notice: 'Organization was successfully created.'
      else
        render :new
      end
    end

    def update
      if @organization.update(organization_params)
        redirect_to admin_organizations_path, notice: 'Organization was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @organization.destroy
      redirect_to admin_organizations_path, notice: 'Organization was successfully destroyed.'
    end

    private

    def set_organization
      @organization = Organization.where(id: params[:id], public: true).take
    end

    def organization_params
      params.require(:organization).permit(:title)
    end
  end
end
