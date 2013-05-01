require 'test_helper'

class Teacher::AssignmentsControllerTest < ActionController::TestCase
  setup do
    @teacher_assignment = teacher_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teacher_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher_assignment" do
    assert_difference('Teacher::Assignment.count') do
      post :create, teacher_assignment: {  }
    end

    assert_redirected_to teacher_assignment_path(assigns(:teacher_assignment))
  end

  test "should show teacher_assignment" do
    get :show, id: @teacher_assignment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher_assignment
    assert_response :success
  end

  test "should update teacher_assignment" do
    put :update, id: @teacher_assignment, teacher_assignment: {  }
    assert_redirected_to teacher_assignment_path(assigns(:teacher_assignment))
  end

  test "should destroy teacher_assignment" do
    assert_difference('Teacher::Assignment.count', -1) do
      delete :destroy, id: @teacher_assignment
    end

    assert_redirected_to teacher_assignments_path
  end
end
