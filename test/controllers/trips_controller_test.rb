require 'test_helper'

class TripsControllerTest < ActionController::TestCase
  test "should get trips" do
    post :getting_trips_api

    assert_response :success
  end

  test "should create trips" do
    post :create_trips

    assert_response :success
  end
end
