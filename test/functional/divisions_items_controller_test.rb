require 'test_helper'

class DivisionsItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:divisions_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create divisions_item" do
    assert_difference('DivisionsItem.count') do
      post :create, :divisions_item => { }
    end

    assert_redirected_to divisions_item_path(assigns(:divisions_item))
  end

  test "should show divisions_item" do
    get :show, :id => divisions_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => divisions_items(:one).to_param
    assert_response :success
  end

  test "should update divisions_item" do
    put :update, :id => divisions_items(:one).to_param, :divisions_item => { }
    assert_redirected_to divisions_item_path(assigns(:divisions_item))
  end

  test "should destroy divisions_item" do
    assert_difference('DivisionsItem.count', -1) do
      delete :destroy, :id => divisions_items(:one).to_param
    end

    assert_redirected_to divisions_items_path
  end
end
