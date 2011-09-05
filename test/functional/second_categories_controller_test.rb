require 'test_helper'

class SecondCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:second_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create second_category" do
    assert_difference('SecondCategory.count') do
      post :create, :second_category => { }
    end

    assert_redirected_to second_category_path(assigns(:second_category))
  end

  test "should show second_category" do
    get :show, :id => second_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => second_categories(:one).to_param
    assert_response :success
  end

  test "should update second_category" do
    put :update, :id => second_categories(:one).to_param, :second_category => { }
    assert_redirected_to second_category_path(assigns(:second_category))
  end

  test "should destroy second_category" do
    assert_difference('SecondCategory.count', -1) do
      delete :destroy, :id => second_categories(:one).to_param
    end

    assert_redirected_to second_categories_path
  end
end
