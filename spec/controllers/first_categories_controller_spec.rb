# -*- coding: utf-8 -*-
require 'spec_helper'
include AuthenticatedTestHelper

describe FirstCategoriesController do
  fixtures :users

  before do
    login_as :data1
  end


  def mock_first_category(stubs={})
    @mock_first_category ||= mock_model(FirstCategory, stubs)
  end

  describe "GET index" do
    it "assigns all first_categories as @first_categories" do
      FirstCategory.stub!(:find).with(:all).and_return([mock_first_category])
      get :index
      assigns[:first_categories].should == [mock_first_category]
    end
  end

  describe "GET show" do
    it "assigns the requested first_category as @first_category" do
      FirstCategory.stub!(:find).with("37").and_return(mock_first_category)
      get :show, :id => "37"
p      assigns[:first_category].should equal(mock_first_category)
    end
  end

  describe "GET new" do
    it "assigns a new first_category as @first_category" do
      get :new, :division_id => "37"
      assigns[:first_category].division_id.should eql(37)
    end

    it "return maintenance when params[:division_id] doesn't exist" do
      get :new
      response.should redirect_to(:controller => :objective,
                                  :action => :maintenance)
    end
  end

  describe "GET edit" do
    it "assigns the requested first_category as @first_category" do
      FirstCategory.stub!(:find).with("37").and_return(mock_first_category)
      get :edit, :id => "37"
      assigns[:first_category].should equal(mock_first_category)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created first_category as @first_category" do
        FirstCategory.stub!(:new).with({'these' => 'params'}).and_return(mock_first_category(:save => true))
        mock_first_category.stub!(:name)
        mock_first_category.stub!(:division_id)

        post :create, :first_category => {:these => 'params'}
        assigns[:first_category].should equal(mock_first_category)
      end

      it "redirects to the objective/maintenance" do
        post :create, :first_category => {:name => "", :division_id => "1"}
        response.should redirect_to(:controller => :objective,
                                    :action => :maintenance,
                                    :id => "1")
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved first_category as @first_category" do
        FirstCategory.stub!(:new).with({'these' => 'params'}).and_return(mock_first_category(:save => false))
        post :create, :first_category => {:these => 'params'}
        assigns[:first_category].should equal(mock_first_category)
      end

      it "re-renders the 'new' template" do
        FirstCategory.stub!(:new).and_return(mock_first_category(:save => false))
        post :create, :first_category => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested first_category" do
        FirstCategory.should_receive(:find).with("37").and_return(mock_first_category)
        mock_first_category.should_receive(:update_attributes).with({'these' => 'params'})

        put :update, :id => "37", :first_category => {:these => 'params'}
      end

      it "assigns the requested first_category as @first_category" do
        FirstCategory.stub!(:find).and_return(mock_first_category(:update_attributes => true))
        mock_first_category.stub!(:name)
        mock_first_category.stub!(:division_id)

        put :update, :id => "1"
        assigns[:first_category].should equal(mock_first_category)
      end

      it "redirects to the first_category" do
        put :update, :id => "1"
        response.should redirect_to(:controller => :objective,
                                    :action => :maintenance,
                                    :id => assigns[:first_category].division_id)
      end
    end

    describe "with invalid params" do
      it "updates the requested first_category" do
        FirstCategory.should_receive(:find).with("37").and_return(mock_first_category)
        mock_first_category.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :first_category => {:these => 'params'}
      end

      it "assigns the first_category as @first_category" do
        FirstCategory.stub!(:find).and_return(mock_first_category(:update_attributes => false))
        put :update, :id => "1"
        assigns[:first_category].should equal(mock_first_category)
      end

      it "re-renders the 'edit' template" do
        FirstCategory.stub!(:find).and_return(mock_first_category(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    fixtures :first_categories, :second_categories, :items

    before do 
      @first_category = first_categories :data1
    end

    it "destroys the requested first_category" do
      FirstCategory.should_receive(:find).with("37").and_return(mock_first_category)
      mock_first_category.stub!(:division_id)
      mock_first_category.stub!(:name)

      mock_first_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "した時、関連する second_categories も削除すること" do
      Proc.new {
        delete :destroy, :id => @first_category.id
      }.should change(SecondCategory, :count)
    end

    it "redirects to the objective/maintenance" do
      delete :destroy, :id => @first_category.id
      response.should redirect_to(:controller => :objective,
                                  :action => :maintenance,
                                  :id => @first_category.division_id)
    end
  end

end
