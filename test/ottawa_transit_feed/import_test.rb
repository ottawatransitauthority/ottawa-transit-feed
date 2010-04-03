require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class ImportTest < ActiveSupport::TestCase

    def setup
      OttawaTransitFeed.clear_database
    end
    
    def transit_feed
      "test/fixtures/transit_feeds/oc_transpo"
    end

    test "4 calendars should be imported" do 
      assert_difference "Calendar.count", +4 do
        OttawaTransitFeed.import transit_feed
      end
    end

    test "imported calendar" do
      OttawaTransitFeed.import transit_feed
      
      calendar = Calendar.find_by_service_id("WEEKDAY_SCHEDULE")
      assert calendar
      assert_equal "20090101", calendar.start_date
      assert_equal "20091231", calendar.end_date
      assert_equal "1", calendar.monday
      assert_equal "1", calendar.tuesday
      assert_equal "1", calendar.wednesday
      assert_equal "1", calendar.thursday
      assert_equal "1", calendar.friday
      assert_equal "0", calendar.saturday
      assert_equal "0", calendar.sunday
    end
    
    test "2 stops should be imported" do
      assert_difference "Stop.count", +2 do
        OttawaTransitFeed.import transit_feed
      end
    end
    
    test "imported stop" do
      OttawaTransitFeed.import transit_feed
      
      stop = Stop.find_by_stop_id("CD920")
      assert_equal "RIDEAU 3A", stop.original_name
      assert_equal "Rideau Centre, Platform 3A", stop.name
      assert_equal "45.426365", stop.lat
      assert_equal "-75.691154", stop.lon
      assert_equal "3009", stop.code
    end
    
    test "1 route should be imported" do
      assert_difference "Route.count", +1 do
        OttawaTransitFeed.import transit_feed
      end
    end
    
    test "imported route" do
      OttawaTransitFeed.import transit_feed
      
      route = Route.last
      assert_equal "1", route.route_id
      assert_equal "1", route.short_name
      assert_equal "South Keys to Ottawa-Rockcliffe", route.long_name
      assert_equal 1, route.number
      assert_equal 1, route.trips.size
    end
    
    test "1 trip should be imported" do
      assert_difference "Trip.count", +1 do
        OttawaTransitFeed.import transit_feed
      end
    end
    
    test "imported trip" do
      OttawaTransitFeed.import transit_feed
      
      trip = Trip.find_by_trip_id("001-WEEKDAY_SCHEDULE")
      assert trip
      assert trip.route
      assert_equal "WEEKDAY_SCHEDULE", trip.service_id
      assert_equal "Ottawa-Rockcliffe", trip.original_headsign
      assert_equal "1", trip.route.route_id
      assert_equal "1 DOWNTOWN", trip.headsign.to_s
    
      # assert_equal "OTTAWA-ROCKCLIFFE", route.heading
      # assert_equal ["RF900", "CD920"], trip.stop_ids
    
    end
  end
end