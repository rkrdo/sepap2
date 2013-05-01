require 'test_helper'

class Teacher::GroupsControllerTest < ActionController::TestCase
  setup do
    @teacher_group = teacher_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teacher_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create teacher_group" do
    assert_difference('Teacher::Group.count') do
      post :create, teacher_group: {  }
    end

    assert_redirected_to teacher_group_path(assigns(:teacher_group))
  end

  test "should show teacher_group" do
    get :show, id: @teacher_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @teacher_group
    assert_response :success
  end

  test "should update teacher_group" do
    put :update, id: @teacher_group, teacher_group: {  }
    assert_redirected_to teacher_group_path(assigns(:teacher_group))
  end

  test "should destroy teacher_group" do
    assert_difference('Teacher::Group.count', -1) do
      delete :destroy, id: @teacher_group
    end

    assert_redirected_to teacher_groups_path
  end
end
