require "#{File.dirname(File.dirname(__FILE__))}/test_helper"
require "oc_transpo"

module OCTranspo
  class MobileRouteDataTest < ActiveSupport::TestCase

    def date
      @date ||= Date.parse("20100323")
    end
    
    def setup
      OCTranspo::MobileRouteData.use_fixtures!
    end
    
    def teardown
      OCTranspo::MobileRouteData.reset!
    end
    
    test "find two sets of data for route 1" do
      route_data = OCTranspo::MobileRouteData.find(1, :date => date)
      assert_equal 2, route_data.size
      
      assert_equal "1",                 route_data[0][:route]
      assert_equal "OTTAWA-ROCKCLIFFE", route_data[0][:direction]
      assert_equal "2",                 route_data[0][:direction_index]
      assert_equal 67,                  route_data[0][:stops].size
      
      assert_equal "1",          route_data[1][:route]
      assert_equal "SOUTH KEYS", route_data[1][:direction]
      assert_equal "1",          route_data[1][:direction_index]
      assert_equal 66,           route_data[1][:stops].size
    end
    
    test "find two sets of data for route 2" do
      route_data = OCTranspo::MobileRouteData.find(2, :date => date)
      assert_equal 2, route_data.size
      
      assert_equal "2",        route_data[0][:route]
      assert_equal "BAYSHORE", route_data[0][:direction]
      assert_equal "2",        route_data[0][:direction_index]
      assert_equal 65,         route_data[0][:stops].size
      
      assert_equal "2",                       route_data[1][:route]
      assert_equal "DOWNTOWN / CENTRE-VILLE", route_data[1][:direction]
      assert_equal "1",                       route_data[1][:direction_index]
      assert_equal 61,                        route_data[1][:stops].size
    end
    
    test "find one sets of data for route 123" do
      route_data = OCTranspo::MobileRouteData.find(123, :date => date)
      assert_equal 1, route_data.size
      
      assert_equal "123",                   route_data[0][:route]
      assert_equal "GLOUCESTER N. & BLAIR", route_data[0][:direction]
      assert_equal "1",                     route_data[0][:direction_index]
      assert_equal 41,                      route_data[0][:stops].size
    end
    
    test "find first set of data for bus route 2" do
      route_direction = OCTranspo::MobileRouteData.find_one_direction(:route => 2, :index => 0, :date => date)
      
      assert route_direction, "route direction is nil"
      
      assert_equal "2",        route_direction[:route]
      assert_equal "BAYSHORE", route_direction[:direction]
      assert_equal "2",        route_direction[:direction_index]
    
      assert route_direction[:stops].all? {|stop| stop.is_a?(Hash) }, "Some stops aren’t hashes!"
      
      first_stop = route_direction[:stops].first
      assert_equal "RIDEAU 4A", first_stop[:name]
      assert_equal "3009",      first_stop[:number]
      assert_equal "RIDEAU",    first_stop[:station]
      assert_equal "4A",        first_stop[:platform]
    
      second_stop = route_direction[:stops].second
      assert_equal "WELLINGTON / METCALFE", second_stop[:name]
      assert_equal "7691",                  second_stop[:number]
      assert second_stop[:station].nil?
      assert second_stop[:platform].nil?
    
      last_stop = route_direction[:stops].last
      assert_equal "BAYSHORE 3A", last_stop[:name]
      assert_equal "3050",        last_stop[:number]
      assert_equal "BAYSHORE",    last_stop[:station]
      assert_equal "3A",          last_stop[:platform]
    end
    
    test "find opposite set of data for bus route 2" do
      route_direction = OCTranspo::MobileRouteData.find_one_direction(:route => 2, :index => 1, :date => date)
      
      assert_equal "2",                       route_direction[:route]
      assert_equal "DOWNTOWN / CENTRE-VILLE", route_direction[:direction]
      assert_equal "1",                       route_direction[:direction_index]
    
      assert route_direction[:stops].all? {|stop| stop.is_a?(Hash) }, "Some stops aren’t hashes!"
            
      first_stop = route_direction[:stops].first
      assert_equal "3050",        first_stop[:number]
      assert_equal "BAYSHORE 4B", first_stop[:name]
      assert_equal "BAYSHORE",    first_stop[:station]
      assert_equal "4B",          first_stop[:platform]
      
      last_stop = route_direction[:stops].last
      assert_equal "3009",      last_stop[:number]
      assert_equal "RIDEAU 3A", last_stop[:name]
      assert_equal "RIDEAU",    last_stop[:station]
      assert_equal "3A",        last_stop[:platform]
    end
    
    test "url_for" do
      expected = "http://www.octranspo.com/mobileweb/jnot/post.routelist.schedules.oci?rangeIndex=5&day=20100323&route=2&routeIndex=0"
      criteria = {:route => 2, :index => 0, :date => date}
      assert_equal expected, OCTranspo::MobileRouteData.url_for(criteria)
      criteria = {:route => 2, :date => date}
      assert_equal expected, OCTranspo::MobileRouteData.url_for(criteria)
    end
    
    test "url_for with index option" do
      expected = "http://www.octranspo.com/mobileweb/jnot/post.routelist.schedules.oci?rangeIndex=5&day=20100323&route=2&routeIndex=1"
      criteria = {:route => 2, :index => 1, :date => date}
      assert_equal expected, OCTranspo::MobileRouteData.url_for(criteria)
    end
  end
end