require 'test_helper'

class Admin::SubjectsControllerTest < ActionController::TestCase
  setup do
    @admin_subject = admin_subjects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_subjects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_subject" do
    assert_difference('Admin::Subject.count') do
      post :create, admin_subject: {  }
    end

    assert_redirected_to admin_subject_path(assigns(:admin_subject))
  end

  test "should show admin_subject" do
    get :show, id: @admin_subject
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_subject
    assert_response :success
  end

  test "should update admin_subject" do
    put :update, id: @admin_subject, admin_subject: {  }
    assert_redirected_to admin_subject_path(assigns(:admin_subject))
  end

  test "should destroy admin_subject" do
    assert_difference('Admin::Subject.count', -1) do
      delete :destroy, id: @admin_subject
    end

    assert_redirected_to admin_subjects_path
  end
end
