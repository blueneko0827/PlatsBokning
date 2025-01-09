require "test_helper"

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reservation = reservations(:one)
  end

  test "should get index" do
    get reservations_url, as: :json
    assert_response :success
  end

  test "should create reservation" do
    assert_difference("Reservation.count") do
      post reservations_url, params: { reservation: { desk_id: @reservation.desk_id, employee_id: @reservation.employee_id, reservation_date: @reservation.reservation_date, reservation_time_from: @reservation.reservation_time_from, reservation_time_to_time: @reservation.reservation_time_to_time } }, as: :json
    end

    assert_response :created
  end

  test "should show reservation" do
    get reservation_url(@reservation), as: :json
    assert_response :success
  end

  test "should update reservation" do
    patch reservation_url(@reservation), params: { reservation: { desk_id: @reservation.desk_id, employee_id: @reservation.employee_id, reservation_date: @reservation.reservation_date, reservation_time_from: @reservation.reservation_time_from, reservation_time_to_time: @reservation.reservation_time_to_time } }, as: :json
    assert_response :success
  end

  test "should destroy reservation" do
    assert_difference("Reservation.count", -1) do
      delete reservation_url(@reservation), as: :json
    end

    assert_response :no_content
  end
end
