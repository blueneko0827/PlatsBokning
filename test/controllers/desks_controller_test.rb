require "test_helper"

class DesksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @desk = desks(:one)
  end

  test "should get index" do
    get desks_url, as: :json
    assert_response :success
  end

  test "should create desk" do
    assert_difference("Desk.count") do
      post desks_url, params: { desk: { desk_number: @desk.desk_number, fixed_employee_id: @desk.fixed_employee_id, floor_number: @desk.floor_number, status_id: @desk.status_id } }, as: :json
    end

    assert_response :created
  end

  test "should show desk" do
    get desk_url(@desk), as: :json
    assert_response :success
  end

  test "should update desk" do
    patch desk_url(@desk), params: { desk: { desk_number: @desk.desk_number, fixed_employee_id: @desk.fixed_employee_id, floor_number: @desk.floor_number, status_id: @desk.status_id } }, as: :json
    assert_response :success
  end

  test "should destroy desk" do
    assert_difference("Desk.count", -1) do
      delete desk_url(@desk), as: :json
    end

    assert_response :no_content
  end
end
