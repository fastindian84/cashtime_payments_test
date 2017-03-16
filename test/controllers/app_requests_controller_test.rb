require 'test_helper'

class AppRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @app_request = app_requests(:one)
  end

  test "should get index" do
    get app_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_app_request_url
    assert_response :success
  end

  test "should create app_request" do
    assert_difference('AppRequest.count') do
      post app_requests_url, params: { app_request: { amount: @app_request.amount, description: @app_request.description, image_url: @app_request.image_url, order_uid: @app_request.order_uid, response: @app_request.response, status: @app_request.status, title: @app_request.title, user_name: @app_request.user_name, user_uid: @app_request.user_uid } }
    end

    assert_redirected_to app_request_url(AppRequest.last)
  end

  test "should show app_request" do
    get app_request_url(@app_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_app_request_url(@app_request)
    assert_response :success
  end

  test "should update app_request" do
    patch app_request_url(@app_request), params: { app_request: { amount: @app_request.amount, description: @app_request.description, image_url: @app_request.image_url, order_uid: @app_request.order_uid, response: @app_request.response, status: @app_request.status, title: @app_request.title, user_name: @app_request.user_name, user_uid: @app_request.user_uid } }
    assert_redirected_to app_request_url(@app_request)
  end

  test "should destroy app_request" do
    assert_difference('AppRequest.count', -1) do
      delete app_request_url(@app_request)
    end

    assert_redirected_to app_requests_url
  end
end
