require 'test_helper'

class DailyAccomplishmentsControllerTest < ActionController::TestCase
  setup do
    @daily_accomplishment = daily_accomplishments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:daily_accomplishments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create daily_accomplishment" do
    assert_difference('DailyAccomplishment.count') do
      post :create, daily_accomplishment: { content: @daily_accomplishment.content }
    end

    assert_redirected_to daily_accomplishment_path(assigns(:daily_accomplishment))
  end

  test "should show daily_accomplishment" do
    get :show, id: @daily_accomplishment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @daily_accomplishment
    assert_response :success
  end

  test "should update daily_accomplishment" do
    patch :update, id: @daily_accomplishment, daily_accomplishment: { content: @daily_accomplishment.content }
    assert_redirected_to daily_accomplishment_path(assigns(:daily_accomplishment))
  end

  test "should destroy daily_accomplishment" do
    assert_difference('DailyAccomplishment.count', -1) do
      delete :destroy, id: @daily_accomplishment
    end

    assert_redirected_to daily_accomplishments_path
  end
end
