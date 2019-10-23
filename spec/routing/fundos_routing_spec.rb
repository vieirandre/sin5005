require "rails_helper"

RSpec.describe FundosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/fundos").to route_to("fundos#index")
    end

    it "routes to #new" do
      expect(:get => "/fundos/new").to route_to("fundos#new")
    end

    it "routes to #show" do
      expect(:get => "/fundos/1").to route_to("fundos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fundos/1/edit").to route_to("fundos#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/fundos").to route_to("fundos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/fundos/1").to route_to("fundos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/fundos/1").to route_to("fundos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fundos/1").to route_to("fundos#destroy", :id => "1")
    end
  end
end
