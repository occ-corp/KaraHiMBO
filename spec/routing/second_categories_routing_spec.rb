require 'spec_helper'

describe SecondCategoriesController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/second_categories/new" }.should route_to(:controller => "second_categories", :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/second_categories/1/edit" }.should route_to(:controller => "second_categories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/second_categories" }.should route_to(:controller => "second_categories", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/second_categories/1" }.should route_to(:controller => "second_categories", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/second_categories/1" }.should route_to(:controller => "second_categories", :action => "destroy", :id => "1") 
    end
  end
end
