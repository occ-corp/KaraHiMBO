require 'spec_helper'

describe ActualsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/actuals" }.should route_to(:controller => "actuals", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/actuals/new" }.should route_to(:controller => "actuals", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/actuals/1" }.should route_to(:controller => "actuals", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/actuals/1/edit" }.should route_to(:controller => "actuals", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/actuals" }.should route_to(:controller => "actuals", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/actuals/1" }.should route_to(:controller => "actuals", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/actuals/1" }.should route_to(:controller => "actuals", :action => "destroy", :id => "1") 
    end
  end
end
