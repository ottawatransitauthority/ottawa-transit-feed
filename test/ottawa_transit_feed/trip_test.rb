require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class TripTest < ActiveSupport::TestCase

    def teardown
      OttawaTransitFeed.clear_database
    end

    def setup_two_bayshore_trip (trip_id = "1-SERVICE_ID")
      StopTime.create! :timestamp => "04:53:00", :stop_id => "CD935", :stop_sequence => 1, :trip_id => trip_id
      StopTime.create! :timestamp => "05:16:00", :stop_id => "NC950", :stop_sequence => 2, :trip_id => trip_id
      StopTime.create! :timestamp => "05:34:00", :stop_id => "WD940", :stop_sequence => 3, :trip_id => trip_id
      
      Trip.create! do |trip|
        trip.service_id    = "SERVICE_ID"
        trip.trip_id       = trip_id
        trip.route_id      = "2-00"
        trip.trip_headsign = "Bayshore"
      end
    end

    test "trip derives route number from original route id" do
      trip = Trip.new(:route_id => "1-00")
      assert_equal 1, trip.route_number
      
      trip = Trip.new(:route_id => "2-00")
      assert_equal 2, trip.route_number
    end

    test "trip derives route heading from original trip headsign" do
      trip = Trip.new(:trip_headsign => "Bayshore")
      assert_equal "BAYSHORE", trip.route_heading
    end

    test "2 BAYSHORE trip provides stop ids" do
      trip = setup_two_bayshore_trip
      assert_equal ["CD935", "NC950", "WD940"], trip.stop_ids
    end

    test "2 BAYSHORE trip provides route" do
      trip = setup_two_bayshore_trip
      assert trip.route
    end
    
    test "routes are shared between trips with identical route numbers, headings and stops" do
      trip_a = setup_two_bayshore_trip("A")
      trip_b = setup_two_bayshore_trip("B")
      assert_equal trip_a.route_number,  trip_b.route_number
      assert_equal trip_a.route_heading, trip_b.route_heading
      assert_equal trip_a.stop_ids,      trip_b.stop_ids
      assert_equal trip_a.route,         trip_b.route
    end
  end
end
