require 'spec_helper'

describe ComparisonsController do

  def mock_comparison(stubs={})
    @mock_comparison ||= mock_model(Comparison, stubs)
  end

  describe "GET index" do
    it "assigns all comparisons as @comparisons" do
      Comparison.stub!(:find).with(:all).and_return([mock_comparison])
      get :index
      assigns[:comparisons].should == [mock_comparison]
    end
  end

  describe "GET show" do
    it "assigns the requested comparison as @comparison" do
      Comparison.stub!(:find).with("37").and_return(mock_comparison)
      get :show, :id => "37"
      assigns[:comparison].should equal(mock_comparison)
    end
  end

  describe "GET new" do
    it "assigns a new comparison as @comparison" do
      Comparison.stub!(:new).and_return(mock_comparison)
      get :new
      assigns[:comparison].should equal(mock_comparison)
    end
  end

  describe "GET edit" do
    it "assigns the requested comparison as @comparison" do
      Comparison.stub!(:find).with("37").and_return(mock_comparison)
      get :edit, :id => "37"
      assigns[:comparison].should equal(mock_comparison)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created comparison as @comparison" do
        Comparison.stub!(:new).with({'these' => 'params'}).and_return(mock_comparison(:save => true))
        post :create, :comparison => {:these => 'params'}
        assigns[:comparison].should equal(mock_comparison)
      end

      it "redirects to the created comparison" do
        Comparison.stub!(:new).and_return(mock_comparison(:save => true))
        post :create, :comparison => {}
        response.should redirect_to(comparison_url(mock_comparison))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comparison as @comparison" do
        Comparison.stub!(:new).with({'these' => 'params'}).and_return(mock_comparison(:save => false))
        post :create, :comparison => {:these => 'params'}
        assigns[:comparison].should equal(mock_comparison)
      end

      it "re-renders the 'new' template" do
        Comparison.stub!(:new).and_return(mock_comparison(:save => false))
        post :create, :comparison => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested comparison" do
        Comparison.should_receive(:find).with("37").and_return(mock_comparison)
        mock_comparison.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :comparison => {:these => 'params'}
      end

      it "assigns the requested comparison as @comparison" do
        Comparison.stub!(:find).and_return(mock_comparison(:update_attributes => true))
        put :update, :id => "1"
        assigns[:comparison].should equal(mock_comparison)
      end

      it "redirects to the comparison" do
        Comparison.stub!(:find).and_return(mock_comparison(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(comparison_url(mock_comparison))
      end
    end

    describe "with invalid params" do
      it "updates the requested comparison" do
        Comparison.should_receive(:find).with("37").and_return(mock_comparison)
        mock_comparison.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :comparison => {:these => 'params'}
      end

      it "assigns the comparison as @comparison" do
        Comparison.stub!(:find).and_return(mock_comparison(:update_attributes => false))
        put :update, :id => "1"
        assigns[:comparison].should equal(mock_comparison)
      end

      it "re-renders the 'edit' template" do
        Comparison.stub!(:find).and_return(mock_comparison(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested comparison" do
      Comparison.should_receive(:find).with("37").and_return(mock_comparison)
      mock_comparison.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the comparisons list" do
      Comparison.stub!(:find).and_return(mock_comparison(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(comparisons_url)
    end
  end

end
