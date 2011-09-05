require 'test_helper'

class BelongsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:belongs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create belong" do
    assert_difference('Belong.count') do
      post :create, :belong => { }
    end

    assert_redirected_to belong_path(assigns(:belong))
  end

  test "should show belong" do
    get :show, :id => belongs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => belongs(:one).to_param
    assert_response :success
  end

  test "should update belong" do
    put :update, :id => belongs(:one).to_param, :belong => { }
    assert_redirected_to belong_path(assigns(:belong))
  end

  test "should destroy belong" do
    assert_difference('Belong.count', -1) do
      delete :destroy, :id => belongs(:one).to_param
    end

    assert_redirected_to belongs_path
  end
end
