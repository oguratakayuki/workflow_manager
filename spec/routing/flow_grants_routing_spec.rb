require "rails_helper"

RSpec.describe FlowGrantsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/flow_grants").to route_to("flow_grants#index")
    end

    it "routes to #new" do
      expect(:get => "/flow_grants/new").to route_to("flow_grants#new")
    end

    it "routes to #show" do
      expect(:get => "/flow_grants/1").to route_to("flow_grants#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/flow_grants/1/edit").to route_to("flow_grants#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/flow_grants").to route_to("flow_grants#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/flow_grants/1").to route_to("flow_grants#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/flow_grants/1").to route_to("flow_grants#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/flow_grants/1").to route_to("flow_grants#destroy", :id => "1")
    end

  end
end
