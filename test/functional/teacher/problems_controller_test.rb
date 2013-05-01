require 'test_helper'

class Teacher::ProblemsControllerTest < ActionController::TestCase
  setup do
    @teacher_problem = teacher_problems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teacher_problems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher_problem" do
    assert_difference('Teacher::Problem.count') do
      post :create, teacher_problem: {  }
    end

    assert_redirected_to teacher_problem_path(assigns(:teacher_problem))
  end

  test "should show teacher_problem" do
    get :show, id: @teacher_problem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher_problem
    assert_response :success
  end

  test "should update teacher_problem" do
    put :update, id: @teacher_problem, teacher_problem: {  }
    assert_redirected_to teacher_problem_path(assigns(:teacher_problem))
  end

  test "should destroy teacher_problem" do
    assert_difference('Teacher::Problem.count', -1) do
      delete :destroy, id: @teacher_problem
    end

    assert_redirected_to teacher_problems_path
  end
end
