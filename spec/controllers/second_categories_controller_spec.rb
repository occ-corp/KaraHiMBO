# -*- coding: utf-8 -*-
require 'spec_helper'

describe SecondCategoriesController do

  def mock_second_category(stubs={})
    @mock_second_category ||= mock_model(SecondCategory, stubs)
  end

  describe "GET index" do
    it "assigns all second_categories as @second_categories" do
      SecondCategory.stub!(:find).with(:all).and_return([mock_second_category])
      get :index
      assigns[:second_categories].should == [mock_second_category]
    end
  end

  describe "GET show" do
    it "assigns the requested second_category as @second_category" do
      SecondCategory.stub!(:find).with("37").and_return(mock_second_category)
      get :show, :id => "37"
      assigns[:second_category].should equal(mock_second_category)
    end
  end

  describe "GET new" do
    it "assigns a new second_category as @second_category" do
      SecondCategory.stub!(:new).and_return(mock_second_category)
      get :new
      assigns[:second_category].should equal(mock_second_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested second_category as @second_category" do
      SecondCategory.stub!(:find).with("37").and_return(mock_second_category)
      get :edit, :id => "37"
      assigns[:second_category].should equal(mock_second_category)
    end
  end

  describe "POST create" do
    fixtures :first_categories, :second_categories

    before do
      @attributes = {
        :name => "name",
        :first_category_id => first_categories(:data1).id
      }
      @params = {:second_category => @attributes}
    end

    describe "with valid params" do
      it "assigns a newly created second_category as @second_category" do 
        flash[:notice] = nil
        post :create, @params
        flash[:notice].should =~ /#{assigns[:second_category].name}.*作成しました/
      end

      it "redirects to the created second_category" do
        post :create, @params
        response.should be_redirect
        response.should redirect_to(:controller => :objective,
                                    :action => :maintenance,
                                    :id => assigns[:second_category].first_category_id)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved second_category as @second_category" do
        SecondCategory.stub!(:new).with({'these' => 'params'}).and_return(mock_second_category(:save => false))
        post :create, :second_category => {:these => 'params'}
        assigns[:second_category].should equal(mock_second_category)
      end

      it "re-renders the 'new' template" do
        SecondCategory.stub!(:new).and_return(mock_second_category(:save => false))
        post :create, :second_category => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do
    fixtures :first_categories, :second_categories

    before do
      @attributes = { :name => "name" }
      @second_category = second_categories(:data1)
      @params = { :id => @second_category.id, :second_category => @attributes }
    end

    describe "with valid params" do
      it "updates the requested second_category" do
        flash[:notice] = nil
        post :update, @params
        flash[:notice].should =~ /#{assigns[:second_category].name}.*更新しました/
      end

      it "redirects to the second_category" do
        post :update, @params
        response.should be_redirect
        response.should redirect_to(:controller => :objective,
                                    :action => :maintenance,
                                    :id => assigns[:second_category].first_category_id)
      end
    end

    describe "with invalid params" do
      it "updates the requested second_category" do
        SecondCategory.should_receive(:find).with("37").and_return(mock_second_category)
        mock_second_category.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :second_category => {:these => 'params'}
      end

      it "assigns the second_category as @second_category" do
        SecondCategory.stub!(:find).and_return(mock_second_category(:update_attributes => false))
        put :update, :id => "1"
        assigns[:second_category].should equal(mock_second_category)
      end

      it "re-renders the 'edit' template" do
        SecondCategory.stub!(:find).and_return(mock_second_category(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    fixtures :first_categories, :second_categories, :divisions

    it "destroys the requested second_category" do
      SecondCategory.should_receive(:find).with("37").and_return(mock_second_category)
      mock_second_category.stub_chain(:first_category, :division, :id)
      mock_second_category.should_receive(:name)
      mock_second_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the objective/maintenance" do
      second_category = second_categories(:data1)
      root_division = second_category.first_category.division.id
      delete :destroy, :id => second_category.id
      response.should redirect_to(:controller => :objective,
                                  :action => :maintenance,
                                  :id => root_division)
    end
  end

end
