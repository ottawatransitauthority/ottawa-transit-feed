require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class TripTest < ActiveSupport::TestCase

    def setup
      OttawaTransitFeed.clear_database
    end

    test "trip derives route id from original route id" do
      trip = Trip.new(:route_id => "1-00")
      assert_equal "1", trip.route_id
      
      trip = Trip.new(:route_id => "2-00")
      assert_equal "2", trip.route_id
    end
    
    test "trip derives route heading from original trip headsign" do
      trip = Trip.new(:trip_headsign => "Bayshore")
      assert_equal "BAYSHORE", trip.route_heading
    end
    
    test "route of a 2 BAYSHORE trip" do
      trip = Trip.new :route_id => "2-00"
      
      assert_equal 2,   trip.route.number
      assert_equal "2", trip.route.route_id
      assert_equal "2", trip.route.short_name
    end
    
    test "routes are shared between trips with identical routes" do
      origin      = Stop.create! :stop_id => "CD935", :name => "RIDEAU 4A"
      destination = Stop.create! :stop_id => "WD940", :name => "BAYSHORE 3A"
      
      trip_a = setup_trip :trip_id => "A", :route_id => "2-00", :trip_headsign => "Bayshore", :stops => [origin, destination]
      trip_b = setup_trip :trip_id => "B", :route_id => "2-00", :trip_headsign => "Bayshore", :stops => [origin, destination]
      
      assert_equal trip_a.route_id, trip_b.route_id
      assert_equal trip_a.route,    trip_b.route
    end
    
    test "stop_times of a 2 BAYSHORE trip" do
      StopTime.create! :trip_id => "ABC", :stop_id => "CD935", :stop_sequence => "1", :timestamp => "00:00:00" 
      StopTime.create! :trip_id => "ABC", :stop_id => "WD940", :stop_sequence => "2", :timestamp => "00:00:00"

      trip = Trip.create! :trip_id => "ABC", :service_id => "WEEKDAY", :route_id => "2"
      
      assert trip.stop_times.any?
      assert_equal ["CD935", "WD940"], trip.stop_ids
    end
    
    # test "set headsign of a 1 OTTAWA-ROCKCLIFFE trip" do
    #   origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
    #   destination = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"
    #   
    #   trip = setup_trip :route_id => "1-00", :trip_headsign => "Ottawa-Rockcliffe", :stops => [origin, destination]
    #   
    #   assert_equal "1 OTTAWA ROCKCLIFFE", trip.headsign
    # end
    # 
    # test "set headsign of a 1 DOWNTOWN trip" do
    #   origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
    #   destination = Stop.create! :name => "RIDEAU 3A", :stop_id => "CD920"
    # 
    #   trip = setup_trip :route_id => "1-00", :trip_headsign => "Ottawa-Rockcliffe", :stops => [origin, destination]
    # 
    #   assert_equal "1 DOWNTOWN", trip.headsign
    # end
    # 
    # test "headsign of a 1 SOUTH KEYS trip" do
    #   origin      = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"
    #   destination = Stop.create! :name => "GREENBORO 1B", :stop_id => "RF905"
    # 
    #   trip = setup_trip :route_id => "1-00", :trip_headsign => "South Keys", :stops => [origin, destination]
    # 
    #   assert_equal "1 SOUTH KEYS", trip.headsign
    # end
    # 
    # test "headsign of a 2 BAYSHORE trip" do
    #   origin      = Stop.create! :name => "RIDEAU 4A", :stop_id => "CD935"
    #   destination = Stop.create! :name => "BAYSHORE 3A", :stop_id => "WD940"
    #   
    #   trip = setup_trip :route_id => "2-00", :trip_headsign => "Bayshore", :stops => [origin, destination]
    #   
    #   assert_equal "2 BAYSHORE", trip.headsign
    # end
    # 
    # test "headsign of a 2 WESTBORO trip" do
    #   origin      = Stop.create! :name => "RIDEAU 4A", :stop_id => "CD935"
    #   destination = Stop.create! :name => "WESTBORO 3A", :stop_id => "NC950"
    #   
    #   trip = setup_trip :route_id => "2-00", :trip_headsign => "Bayshore", :stops => [origin, destination]
    # 
    #   assert_equal "2 WESTBORO", trip.headsign
    # end
    # 
    # test "headsign of a 2 DOWNTOWN trip" do
    #   origin      = Stop.create! :name => "BAYSHORE 4B", :stop_id => "WD960"
    #   destination = Stop.create! :name => "RIDEAU 3A", :stop_id => "CD920"
    #         
    #   trip = setup_trip :route_id => "2-00", :trip_headsign => "DOWNTOWN / CENTRE-VILLE", :stops => [origin, destination]
    # 
    #   assert_equal "2 DOWNTOWN", trip.headsign
    # end

    def setup_trip (options={})
      options[:service_id] ||= "SERVICE_ID"
      options[:trip_id]    ||= "000-#{options[:service_id]}"
      
      options[:stops].each_with_index do |stop, index|
        StopTime.create! :stop_id => stop.stop_id, :stop_sequence => index+1, :timestamp => "00:00:00", :trip_id => options[:trip_id]
      end
      
      trip = Trip.create! do |trip|
        trip.service_id    = options[:service_id]
        trip.trip_id       = options[:trip_id]
        trip.route_id      = options[:route_id]
        trip.trip_headsign = options[:trip_headsign]
      end
    end
  end
end
