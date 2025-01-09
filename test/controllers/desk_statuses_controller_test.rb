require "test_helper"

class DeskStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @desk_status = desk_statuses(:one)
  end

  test "should get index" do
    get desk_statuses_url, as: :json
    assert_response :success
  end

  test "should create desk_status" do
    assert_difference("DeskStatus.count") do
      post desk_statuses_url, params: { desk_status: { status_name: @desk_status.status_name } }, as: :json
    end

    assert_response :created
  end

  test "should show desk_status" do
    get desk_status_url(@desk_status), as: :json
    assert_response :success
  end

  test "should update desk_status" do
    patch desk_status_url(@desk_status), params: { desk_status: { status_name: @desk_status.status_name } }, as: :json
    assert_response :success
  end

  test "should destroy desk_status" do
    assert_difference("DeskStatus.count", -1) do
      delete desk_status_url(@desk_status), as: :json
    end

    assert_response :no_content
  end
end
