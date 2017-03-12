require "rails_helper"

RSpec.describe Admin::MenusController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin/menus").to route_to("admin/menus#index")
    end

    it "routes to #new" do
      expect(:get => "/admin/menus/new").to route_to("admin/menus#new")
    end

    it "routes to #show" do
      expect(:get => "/admin/menus/1").to route_to("admin/menus#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin/menus/1/edit").to route_to("admin/menus#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin/menus").to route_to("admin/menus#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/admin/menus/1").to route_to("admin/menus#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/admin/menus/1").to route_to("admin/menus#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin/menus/1").to route_to("admin/menus#destroy", :id => "1")
    end

  end
end
