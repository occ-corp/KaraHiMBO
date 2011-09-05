require 'spec_helper'

describe DivisionsItemsController do

  def mock_divisions_item(stubs={})
    @mock_divisions_item ||= mock_model(DivisionsItem, stubs)
  end

  describe "GET index" do
    it "assigns all divisions_items as @divisions_items" do
      DivisionsItem.stub!(:find).with(:all).and_return([mock_divisions_item])
      get :index
      assigns[:divisions_items].should == [mock_divisions_item]
    end
  end

  describe "GET show" do
    it "assigns the requested divisions_item as @divisions_item" do
      DivisionsItem.stub!(:find).with("37").and_return(mock_divisions_item)
      get :show, :id => "37"
      assigns[:divisions_item].should equal(mock_divisions_item)
    end
  end

  describe "GET new" do
    it "assigns a new divisions_item as @divisions_item" do
      DivisionsItem.stub!(:new).and_return(mock_divisions_item)
      get :new
      assigns[:divisions_item].should equal(mock_divisions_item)
    end
  end

  describe "GET edit" do
    it "assigns the requested divisions_item as @divisions_item" do
      DivisionsItem.stub!(:find).with("37").and_return(mock_divisions_item)
      get :edit, :id => "37"
      assigns[:divisions_item].should equal(mock_divisions_item)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created divisions_item as @divisions_item" do
        DivisionsItem.stub!(:new).with({'these' => 'params'}).and_return(mock_divisions_item(:save => true))
        post :create, :divisions_item => {:these => 'params'}
        assigns[:divisions_item].should equal(mock_divisions_item)
      end

      it "redirects to the created divisions_item" do
        DivisionsItem.stub!(:new).and_return(mock_divisions_item(:save => true))
        post :create, :divisions_item => {}
        response.should redirect_to(divisions_item_url(mock_divisions_item))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved divisions_item as @divisions_item" do
        DivisionsItem.stub!(:new).with({'these' => 'params'}).and_return(mock_divisions_item(:save => false))
        post :create, :divisions_item => {:these => 'params'}
        assigns[:divisions_item].should equal(mock_divisions_item)
      end

      it "re-renders the 'new' template" do
        DivisionsItem.stub!(:new).and_return(mock_divisions_item(:save => false))
        post :create, :divisions_item => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested divisions_item" do
        DivisionsItem.should_receive(:find).with("37").and_return(mock_divisions_item)
        mock_divisions_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :divisions_item => {:these => 'params'}
      end

      it "assigns the requested divisions_item as @divisions_item" do
        DivisionsItem.stub!(:find).and_return(mock_divisions_item(:update_attributes => true))
        put :update, :id => "1"
        assigns[:divisions_item].should equal(mock_divisions_item)
      end

      it "redirects to the divisions_item" do
        DivisionsItem.stub!(:find).and_return(mock_divisions_item(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(divisions_item_url(mock_divisions_item))
      end
    end

    describe "with invalid params" do
      it "updates the requested divisions_item" do
        DivisionsItem.should_receive(:find).with("37").and_return(mock_divisions_item)
        mock_divisions_item.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :divisions_item => {:these => 'params'}
      end

      it "assigns the divisions_item as @divisions_item" do
        DivisionsItem.stub!(:find).and_return(mock_divisions_item(:update_attributes => false))
        put :update, :id => "1"
        assigns[:divisions_item].should equal(mock_divisions_item)
      end

      it "re-renders the 'edit' template" do
        DivisionsItem.stub!(:find).and_return(mock_divisions_item(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested divisions_item" do
      DivisionsItem.should_receive(:find).with("37").and_return(mock_divisions_item)
      mock_divisions_item.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the divisions_items list" do
      DivisionsItem.stub!(:find).and_return(mock_divisions_item(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(divisions_items_url)
    end
  end

end
