require 'spec_helper'

describe FirstCategoriesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/first_categories" }.should route_to(:controller => "first_categories", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/first_categories/new" }.should route_to(:controller => "first_categories", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/first_categories/1" }.should route_to(:controller => "first_categories", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/first_categories/1/edit" }.should route_to(:controller => "first_categories", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/first_categories" }.should route_to(:controller => "first_categories", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/first_categories/1" }.should route_to(:controller => "first_categories", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/first_categories/1" }.should route_to(:controller => "first_categories", :action => "destroy", :id => "1") 
    end
  end
end
