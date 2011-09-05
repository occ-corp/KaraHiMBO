require 'test_helper'

class FirstCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:first_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create first_category" do
    assert_difference('FirstCategory.count') do
      post :create, :first_category => { }
    end

    assert_redirected_to first_category_path(assigns(:first_category))
  end

  test "should show first_category" do
    get :show, :id => first_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => first_categories(:one).to_param
    assert_response :success
  end

  test "should update first_category" do
    put :update, :id => first_categories(:one).to_param, :first_category => { }
    assert_redirected_to first_category_path(assigns(:first_category))
  end

  test "should destroy first_category" do
    assert_difference('FirstCategory.count', -1) do
      delete :destroy, :id => first_categories(:one).to_param
    end

    assert_redirected_to first_categories_path
  end
end
