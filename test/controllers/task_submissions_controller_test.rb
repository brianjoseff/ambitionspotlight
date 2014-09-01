require 'test_helper'

class TaskSubmissionsControllerTest < ActionController::TestCase
  setup do
    @task_submission = task_submissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:task_submissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create task_submission" do
    assert_difference('TaskSubmission.count') do
      post :create, task_submission: { status: @task_submission.status, task_id: @task_submission.task_id, user_id: @task_submission.user_id }
    end

    assert_redirected_to task_submission_path(assigns(:task_submission))
  end

  test "should show task_submission" do
    get :show, id: @task_submission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @task_submission
    assert_response :success
  end

  test "should update task_submission" do
    patch :update, id: @task_submission, task_submission: { status: @task_submission.status, task_id: @task_submission.task_id, user_id: @task_submission.user_id }
    assert_redirected_to task_submission_path(assigns(:task_submission))
  end

  test "should destroy task_submission" do
    assert_difference('TaskSubmission.count', -1) do
      delete :destroy, id: @task_submission
    end

    assert_redirected_to task_submissions_path
  end
end
