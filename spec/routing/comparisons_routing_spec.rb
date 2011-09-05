require 'spec_helper'

describe ComparisonsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/comparisons" }.should route_to(:controller => "comparisons", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/comparisons/new" }.should route_to(:controller => "comparisons", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/comparisons/1" }.should route_to(:controller => "comparisons", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/comparisons/1/edit" }.should route_to(:controller => "comparisons", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/comparisons" }.should route_to(:controller => "comparisons", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/comparisons/1" }.should route_to(:controller => "comparisons", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/comparisons/1" }.should route_to(:controller => "comparisons", :action => "destroy", :id => "1") 
    end
  end
end
