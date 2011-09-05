require 'spec_helper'

describe ActualsController do

  def mock_actual(stubs={})
    @mock_actual ||= mock_model(Actual, stubs)
  end

  describe "GET index" do
    it "assigns all actuals as @actuals" do
      Actual.stub!(:find).with(:all).and_return([mock_actual])
      get :index
      assigns[:actuals].should == [mock_actual]
    end
  end

  describe "GET show" do
    it "assigns the requested actual as @actual" do
      Actual.stub!(:find).with("37").and_return(mock_actual)
      get :show, :id => "37"
      assigns[:actual].should equal(mock_actual)
    end
  end

  describe "GET new" do
    it "assigns a new actual as @actual" do
      Actual.stub!(:new).and_return(mock_actual)
      get :new
      assigns[:actual].should equal(mock_actual)
    end
  end

  describe "GET edit" do
    it "assigns the requested actual as @actual" do
      Actual.stub!(:find).with("37").and_return(mock_actual)
      get :edit, :id => "37"
      assigns[:actual].should equal(mock_actual)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created actual as @actual" do
        Actual.stub!(:new).with({'these' => 'params'}).and_return(mock_actual(:save => true))
        post :create, :actual => {:these => 'params'}
        assigns[:actual].should equal(mock_actual)
      end

      it "redirects to the created actual" do
        Actual.stub!(:new).and_return(mock_actual(:save => true))
        post :create, :actual => {}
        response.should redirect_to(actual_url(mock_actual))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved actual as @actual" do
        Actual.stub!(:new).with({'these' => 'params'}).and_return(mock_actual(:save => false))
        post :create, :actual => {:these => 'params'}
        assigns[:actual].should equal(mock_actual)
      end

      it "re-renders the 'new' template" do
        Actual.stub!(:new).and_return(mock_actual(:save => false))
        post :create, :actual => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested actual" do
        Actual.should_receive(:find).with("37").and_return(mock_actual)
        mock_actual.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :actual => {:these => 'params'}
      end

      it "assigns the requested actual as @actual" do
        Actual.stub!(:find).and_return(mock_actual(:update_attributes => true))
        put :update, :id => "1"
        assigns[:actual].should equal(mock_actual)
      end

      it "redirects to the actual" do
        Actual.stub!(:find).and_return(mock_actual(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(actual_url(mock_actual))
      end
    end

    describe "with invalid params" do
      it "updates the requested actual" do
        Actual.should_receive(:find).with("37").and_return(mock_actual)
        mock_actual.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :actual => {:these => 'params'}
      end

      it "assigns the actual as @actual" do
        Actual.stub!(:find).and_return(mock_actual(:update_attributes => false))
        put :update, :id => "1"
        assigns[:actual].should equal(mock_actual)
      end

      it "re-renders the 'edit' template" do
        Actual.stub!(:find).and_return(mock_actual(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested actual" do
      Actual.should_receive(:find).with("37").and_return(mock_actual)
      mock_actual.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the actuals list" do
      Actual.stub!(:find).and_return(mock_actual(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(actuals_url)
    end
  end

end
