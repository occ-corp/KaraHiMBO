require 'spec_helper'

describe DivisionsItemsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/divisions_items" }.should route_to(:controller => "divisions_items", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/divisions_items/new" }.should route_to(:controller => "divisions_items", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/divisions_items/1" }.should route_to(:controller => "divisions_items", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/divisions_items/1/edit" }.should route_to(:controller => "divisions_items", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/divisions_items" }.should route_to(:controller => "divisions_items", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/divisions_items/1" }.should route_to(:controller => "divisions_items", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/divisions_items/1" }.should route_to(:controller => "divisions_items", :action => "destroy", :id => "1") 
    end
  end
end
