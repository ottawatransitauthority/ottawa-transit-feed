require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class ImportTest < ActiveSupport::TestCase

    def setup
      OttawaTransitFeed.clear_database
      OttawaTransitFeed.import "test/fixtures/transit_feeds/oc_transpo"
    end

    test "4 calendars should be imported" do 
      assert_equal 4, Calendar.count      
    end

    test "imported calendar" do 
      calendar = Calendar.find_by_service_id("WEEKDAY_SCHEDULE")
      assert calendar
      assert_equal "20090101", calendar.start_date
      assert_equal "20091231", calendar.end_date
      assert calendar.monday?
      assert calendar.tuesday?
      assert calendar.wednesday?
      assert calendar.thursday?
      assert calendar.friday?
      assert_equal false, calendar.saturday?
      assert_equal false, calendar.sunday?
    end

    test "2 stops should be imported" do
      assert_equal 2, Stop.count      
    end

    test "imported stop" do
      stop = Stop.find_by_stop_id("CD920")
      assert_equal "RIDEAU 3A", stop.original_name
      assert_equal "Rideau Centre, Platform 3A", stop.name
      assert_equal "45.426365", stop.lat
      assert_equal "-75.691154", stop.lon
      assert_equal "3009", stop.code
    end

    test "1 route should be imported" do
      assert_equal 1, Route.count
    end

    test "imported route" do
      route = Route.last
      assert_equal "a5dfc1ee6580b9cbc956524560cba1f7", route.route_id
      assert_equal "1 DOWNTOWN", route.headsign
      assert_equal "1", route.short_name
      assert_equal "DOWNTOWN", route.long_name
      assert_equal "OTTAWA-ROCKCLIFFE", route.heading
      assert_equal ["RF900", "CD920"], route.stop_ids
      assert_equal 2, route.stops.size
      assert_equal 1, route.trips.size
    end
    
    test "1 trip should be imported" do
      assert_equal 1, Trip.count
    end
    
    test "imported trip" do 
      trip = Trip.find_by_trip_id("001-WEEKDAY_SCHEDULE")
      assert trip
      assert trip.route
      assert_equal "WEEKDAY_SCHEDULE", trip.service_id
      assert_equal "Ottawa-Rockcliffe", trip.original_headsign
      assert_equal "a5dfc1ee6580b9cbc956524560cba1f7", trip.route.route_id
      assert_equal "1 DOWNTOWN", trip.route.headsign
    end
  end
end