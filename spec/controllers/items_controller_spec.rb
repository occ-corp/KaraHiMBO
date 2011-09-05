# -*- coding: utf-8 -*-
require 'spec_helper'

describe ItemsController do

  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs)
  end

  def mock_division(stubs={})
    @mock_division ||= mock_model(Division, stubs)
  end

  describe "GET index" do
    it "assigns all items as @items" do
      Item.stub!(:find).with(:all, :order => :id).and_return([mock_item])
      get :index
      assigns[:items].should == [mock_item]
    end
  end

  describe "GET show" do
    it "assigns the requested item as @item" do
      Item.stub!(:find_with_categories).with("1").and_return(mock_item)
      get :show, :id => "1"
      assigns[:item].should equal(mock_item)
    end
  end

  describe "GET new" do
    it "assigns a new item as @item" do
      Item.should_receive(:new).with(:second_category_id => "1").and_return(mock_item)
      
      get :new, :second_category_id => "1", :division_id => "1"
      assigns[:item].should equal(mock_item)
      assigns[:root_division].should eql("1")
    end

    it "redirect to 'objective/maintenance' when second_category_id or division_id are not in params" do 
      get :new
      flash[:notice].should eql("項目を作成したい部署を選択してからでなければいけません")
      response.should redirect_to(:controller => :objective, :action => :maintenance)
    end
  end

  describe "GET edit" do
    it "assigns the requested item as @item" do
      mock_divisions = [mock_model(Division)]
      Item.stub!(:find).with("1").and_return(mock_item)
      mock_item.stub!(:divisions).and_return(mock_divisions)
      get :edit, :id => "1"
      assigns[:item].should equal(mock_item)
    end
  end

  describe "POST create" do
    fixtures :divisions

    describe "でパラメータが正しい時" do
      before do 
        @root_division = divisions :data1
        @valid_attributes = {
          :name => "value for name",
          :second_category_id => 1,
          :unit => "value for unit",
          :target_index => "value for target_index",
          :entire_index => 1.5,
          :person_year_index => 1.5,
          :person_month_index => 1.5,
          :comparison_id => 1
        }
        @params = {
          :item => @valid_attributes,
          :root_division => @root_division
        }
      end

      it "新しく Item を生成すること" do
        flash[:notice] = nil
        post :create, @params
        flash[:notice].should =~ /#{assigns[:item].name}.*作成しました/
      end

      it "division_id が指定されていれば、item が指定された Division を持っていること" do
        @params[:division_id] = [1,2,3]
        post :create, @params
        assigns[:item].divisions.should =~ Division.find(1,2,3)
      end

      it "生成後、objective/maintenance にリダイレクトすること" do
        post :create, @params
        response.should be_redirect
        response.should redirect_to(:controller => :objective,
                                    :action => :maintenance,
                                    :id => assigns[:root_division])
      end
    end
    
    describe "with invalid params" do
      it "re-renders the 'new' template" do
        mock_divisions = [mock_model(Division)]
        Item.should_receive(:new).and_return(mock_item(:save => false))
        mock_item.should_receive(:divisions).and_return(mock_divisions)
        mock_divisions.should_receive(:<<).with([]).and_return([mock_model(Division)])
        mock_item.should_receive(:save!).and_raise("mockError")

        post :create, :item => {}, :division_id => []
        response.should render_template('new')
      end
    end
  end

  describe "PUT update" do
    fixtures :items, :divisions

    before do
      @root_division = divisions :data1
      @update_attributes = {
        :name => "value for name",
        :comparison_id => 2
      }
      @item = items(:data1)
      @params = {
        :id => @item.id, :item => @update_attributes,
        :root_division => @root_division
      }
    end

    describe "でパラメータが正しい時" do
      it "Item を更新すること" do
        flash[:notice] = nil
        post :update, @params
        flash[:notice].should =~ /#{assigns[:item].name}.*更新/
      end

      it "division_id が指定されていれば、item が指定された Division を持っていること" do
        @params[:division_id] = [1,2,3]
        post :update, @params
        assigns[:item].divisions.should =~ Division.find(1,2,3)
      end

      it "division_id が指定されていれなければ、item は division を持っていないこと" do
        post :update, @params
        assigns[:item].divisions.should have(0).items
      end

      it "更新後、objective/maintenance/root_division にリダイレクトすること" do
        post :update, @params
        response.should be_redirect
        response.should redirect_to(:controller => :objective,
                                    :action => :maintenance,
                                    :id => assigns[:root_division])
      end
      it "redirects to the item" do
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template" do
        mock_divisions = [mock_division]
        Item.stub!(:find).and_return(mock_item(:update_attributes! => false))
        mock_item.stub!(:divisions).and_return(mock_divisions)
        mock_divisions.stub!(:<<).with(Division.find([])).and_return(mock_divisions)
        mock_item.should_receive(:update_attributes!).and_raise("mockError")
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    fixtures :divisions, :items

    it "destroys the requested item" do
      Item.should_receive(:find).with("37").and_return(mock_item)
      mock_item.should_receive(:name)
      mock_item.should_receive(:destroy)

      delete :destroy, :id => "37"
    end

    it "redirects to the items list" do
      delete :destroy, :id => "1", :root_division => divisions(:data1).id
      response.should redirect_to(:controller => :objective,
                                  :action => :maintenance,
                                  :id => divisions(:data1).id)
    end
  end
end
