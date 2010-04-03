require "#{File.dirname(File.dirname(__FILE__))}/test_helper"
require "oc_transpo"

module OCTranspo
  class MobileRouteScheduleTest < ActiveSupport::TestCase

    def setup
      OCTranspo::MobileRouteData.use_fixtures!
      OCTranspo::MobileRouteSchedule.use_fixtures!
    end
    
    def teardown
      OCTranspo::MobileRouteData.reset!
      OCTranspo::MobileRouteSchedule.reset!
    end
    
    def date
      @date ||= Date.parse("20100323")
    end
    
    def assert_departures_are_in_correct_timezone (departures)
      assert departures.any?
      assert departures.all? {|d| d[:time].utc_offset === Time.current.utc_offset }, "Some departure times are not in the expected time zone"
    end
    
    test "url_for with direction" do
      expected = "http://www.octranspo.com/mobileweb/jnot/post.stoplist.schedules.oci?rangeIndex=5&day=20100323&route=1&direction=Direction1&check0=on"
      criteria = {:route => 1, :direction => "SOUTH KEYS", :date => date}
      assert_equal expected, OCTranspo::MobileRouteSchedule.url_for(criteria)
    
      expected = "http://www.octranspo.com/mobileweb/jnot/post.stoplist.schedules.oci?rangeIndex=5&day=20100323&route=1&direction=Direction2&check0=on"
      criteria = {:route => 1, :direction => "OTTAWA-ROCKCLIFFE", :date => date}
      assert_equal expected, OCTranspo::MobileRouteSchedule.url_for(criteria)
    end

    test "url_for with direction index" do
      expected = "http://www.octranspo.com/mobileweb/jnot/post.stoplist.schedules.oci?rangeIndex=5&day=20100323&route=1&direction=Direction1&check0=on"
      criteria = {:route => 1, :direction_index => 1, :date => date}
      assert_equal expected, OCTranspo::MobileRouteSchedule.url_for(criteria)

      expected = "http://www.octranspo.com/mobileweb/jnot/post.stoplist.schedules.oci?rangeIndex=5&day=20100323&route=1&direction=Direction2&check0=on"
      criteria = {:route => 1, :direction_index => 2, :date => date}
      assert_equal expected, OCTranspo::MobileRouteSchedule.url_for(criteria)
    end
    
    test "url_for with location index option" do
      expected = "http://www.octranspo.com/mobileweb/jnot/post.stoplist.schedules.oci?rangeIndex=5&day=20100323&route=1&direction=Direction1&check2=on"
      criteria = {:route => 1, :location_index => 2, :date => date}
      assert_equal expected, OCTranspo::MobileRouteSchedule.url_for(criteria)
    end

    test "find schedule for route 1 going to South Keys from bus stop 8789 (the first stop on the route)" do
      criteria = {:route => 1, :direction => "SOUTH KEYS", :location_index => 0, :date => date}
      schedule = OCTranspo::MobileRouteSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,                       schedule[:date]
      assert_equal "8789",                     schedule[:location][:number]
      assert_equal "MAPLE LANE / SPRINGFIELD", schedule[:location][:name]
      assert_equal "1",                        schedule[:route]
      assert_equal "SOUTH KEYS",               schedule[:direction]
    
      assert_departures_are_in_correct_timezone schedule[:departures]
      
      first_departure = schedule[:departures].first
      assert_equal date.at("05:52"), first_departure[:time]
      assert_equal "SOUTH KEYS", first_departure[:destination]
          
      last_departure = schedule[:departures].last
      assert_equal date.at("23:11"), last_departure[:time]
      assert_equal "SOUTH KEYS", last_departure[:destination]
    end
    
    test "find schedule for route 1 going to South Keys from bus stop 8789 (the first stop on the route) using direction index" do
      criteria = {:route => 1, :direction_index => 1, :location_index => 0, :date => date}
      schedule = OCTranspo::MobileRouteSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date, schedule[:date]
      assert_equal "8789", schedule[:location][:number]
      assert_equal "MAPLE LANE / SPRINGFIELD", schedule[:location][:name]
      assert_equal "1",                        schedule[:route]
      assert_equal "SOUTH KEYS",               schedule[:direction]
    
      assert_departures_are_in_correct_timezone schedule[:departures]
      
      first_departure = schedule[:departures].first
      assert_equal date.at("05:52"), first_departure[:time]
      assert_equal "SOUTH KEYS", first_departure[:destination]
    
      last_departure = schedule[:departures].last
      assert_equal date.at("23:11"), last_departure[:time]
      assert_equal "SOUTH KEYS", last_departure[:destination]
    end
    
    test "find schedule for route 2 going to Bayshore from bus stop 1987 (the twelth stop on the route)" do
      criteria = {:route => 2, :direction => "BAYSHORE", :location_index => 11, :date => date}
      schedule = OCTranspo::MobileRouteSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,                     schedule[:date]
      assert_equal "1987",                   schedule[:location][:number]
      assert_equal "SOMERSET O-W / BRONSON", schedule[:location][:name]
      assert_equal "2",                      schedule[:route]
      assert_equal "BAYSHORE",               schedule[:direction]
    
      assert_departures_are_in_correct_timezone schedule[:departures]
      
      first_departure = schedule[:departures].first
      assert_equal date.at('05:03'), first_departure[:time]
      assert_equal "BAYSHORE", first_departure[:destination]
      
      last_departure = schedule[:departures].last
      assert_equal date.next.at('01:18'), last_departure[:time]
      assert_equal "BAYSHORE", last_departure[:destination]
    end

    test "find schedule for route 2 going to Bayshore from bus stop 1987 (the twelth stop on the route) using direction index" do
      criteria = {:route => 2, :direction_index => 2, :location_index => 11, :date => date}
      schedule = OCTranspo::MobileRouteSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,                     schedule[:date]
      assert_equal "1987",                   schedule[:location][:number]
      assert_equal "SOMERSET O-W / BRONSON", schedule[:location][:name]
      assert_equal "2",                      schedule[:route]
      assert_equal "BAYSHORE",               schedule[:direction]
    
      assert_departures_are_in_correct_timezone schedule[:departures]
      
      first_departure = schedule[:departures].first
      assert_equal date.at('05:03'), first_departure[:time]
      assert_equal "BAYSHORE", first_departure[:destination]
      
      last_departure = schedule[:departures].last
      assert_equal date.next.at('01:18'), last_departure[:time]
      assert_equal "BAYSHORE", last_departure[:destination]
    end
    
    test "find schedule for route 3 heading toward Colonnade from RIDEAU 4A (the first stop on the route)" do
      criteria = {:route => 3, :direction => "COLONNADE", :location_index => 0, :date => date}
      schedule = OCTranspo::MobileRouteSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,            schedule[:date]
      assert_equal "3009",          schedule[:location][:number]
      assert_equal "RIDEAU 4A",     schedule[:location][:name]
      assert_equal "3",             schedule[:route]
      assert_equal "COLONNADE",     schedule[:direction]
      
      assert_departures_are_in_correct_timezone schedule[:departures]
      
      first_departure = schedule[:departures].first
      assert_equal date.at('06:04'), first_departure[:time]
      assert_equal "COLONNADE", first_departure[:destination]
      
      last_departure = schedule[:departures].last
      assert_equal date.at('23:47'), last_departure[:time]
      assert_equal "COLONNADE", last_departure[:destination]
      
      last_nepean_centre_departure = schedule[:departures][-14]
      assert_equal date.at('17:36'), last_nepean_centre_departure[:time]
      assert_equal "3X NEPEAN CENTRE MERIVALE VIEWMOUNT", last_nepean_centre_departure[:destination]
    end
    
    test "find schedule for route 3 heading toward Colonnade from bus stop 7558 (the second stop on the route)" do
      criteria = {:route => 3, :direction => "COLONNADE", :location_index => 1, :date => date}
      schedule = OCTranspo::MobileRouteSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,            schedule[:date]
      assert_equal "7558",          schedule[:location][:number]
      assert_equal "ELGIN / QUEEN", schedule[:location][:name]
      assert_equal "3",             schedule[:route]
      assert_equal "COLONNADE",     schedule[:direction]
      
      assert_departures_are_in_correct_timezone schedule[:departures]
      
      first_departure = schedule[:departures].first
      assert_equal date.at('06:06'), first_departure[:time]
      assert_equal "COLONNADE", first_departure[:destination]
      
      last_departure = schedule[:departures].last
      assert_equal date.at('23:49'), last_departure[:time]
      assert_equal "COLONNADE", last_departure[:destination]
      
      last_nepean_centre_departure = schedule[:departures][-14]
      assert_equal date.at('17:38'), last_nepean_centre_departure[:time]
      assert_equal "3X NEPEAN CENTRE MERIVALE VIEWMOUNT", last_nepean_centre_departure[:destination]
    end
    
    # test "find schedule for a route at a stop without a number" do
    #   criteria = {:route => 18, :direction_index => 2, :location_index => 25, :date => date}
    #   schedule = OCTranspo::MobileRouteSchedule.find_one(criteria)
    #   
    #   assert schedule
    #   assert_equal date, schedule[:date]
    #   assert_equal "QUILL / GLYNN", schedule[:location][:name]
    #   assert schedule[:location][:number].nil?
    #   assert_equal "18", schedule[:route]
    #   assert_equal "BRITANNIA", schedule[:direction]
    #   assert schedule[:departures].any?
    #   
    #   assert_equal "VIA CROYDON   REGINA",    schedule[:destinations]['x']
    #   assert_equal "DOWNTOWN   CENTRE-VILLE", schedule[:destinations]['y']
    #   assert_equal "VIA CASSELS   BRADFORD",  schedule[:destinations]['D']
    # end
  end
end