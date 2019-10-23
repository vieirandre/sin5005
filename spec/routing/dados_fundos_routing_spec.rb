require "rails_helper"

RSpec.describe DadosFundosController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/dados_fundos").to route_to("dados_fundos#index")
    end

    it "routes to #new" do
      expect(:get => "/dados_fundos/new").to route_to("dados_fundos#new")
    end

    it "routes to #show" do
      expect(:get => "/dados_fundos/1").to route_to("dados_fundos#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/dados_fundos/1/edit").to route_to("dados_fundos#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/dados_fundos").to route_to("dados_fundos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/dados_fundos/1").to route_to("dados_fundos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/dados_fundos/1").to route_to("dados_fundos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/dados_fundos/1").to route_to("dados_fundos#destroy", :id => "1")
    end
  end
end
