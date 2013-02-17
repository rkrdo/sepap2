require 'test_helper'

class Admin::ProblemsControllerTest < ActionController::TestCase
  setup do
    @admin_problem = admin_problems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_problems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_problem" do
    assert_difference('Admin::Problem.count') do
      post :create, admin_problem: {  }
    end

    assert_redirected_to admin_problem_path(assigns(:admin_problem))
  end

  test "should show admin_problem" do
    get :show, id: @admin_problem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_problem
    assert_response :success
  end

  test "should update admin_problem" do
    put :update, id: @admin_problem, admin_problem: {  }
    assert_redirected_to admin_problem_path(assigns(:admin_problem))
  end

  test "should destroy admin_problem" do
    assert_difference('Admin::Problem.count', -1) do
      delete :destroy, id: @admin_problem
    end

    assert_redirected_to admin_problems_path
  end
end
