require 'test_helper'

class TripTest < ActiveSupport::TestCase
  test "should not save trip without user" do
    trip = Trip.new()
    trip.start_time = "2018-10-10"
    assert_not trip.save
  end

  test "should not save trip without vehicle" do
    trip = Trip.new()
    trip.start_time = "2018-10-10"
    assert_not trip.save
  end
end
