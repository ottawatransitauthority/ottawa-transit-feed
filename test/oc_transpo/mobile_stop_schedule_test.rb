require "#{File.dirname(File.dirname(__FILE__))}/test_helper"
require "oc_transpo"

module OCTranspo
  class MobileStopScheduleTest < ActiveSupport::TestCase

    def setup
      OCTranspo::MobileStopSchedule.use_fixtures!
    end
    
    def teardown
      OCTranspo::MobileStopSchedule.reset!
    end
    
    def date
      @date ||= Date.parse("20100323")
    end
    
    test "url_for" do
      expected = "http://www.octranspo.com/mobileweb/jnot/post.routelist.stoptimes.oci?rangeIndex=5&day=20100323&stop=1987&check0=on"
      criteria = {:location => 1987, :route_index => 0, :date => date}
      assert_equal expected, OCTranspo::MobileStopSchedule.url_for(criteria)
      criteria = {:location => 1987, :date => date}
      assert_equal expected, OCTranspo::MobileStopSchedule.url_for(criteria)
    end
    
    test "url_for with route index option" do
      expected = "http://www.octranspo.com/mobileweb/jnot/post.routelist.stoptimes.oci?rangeIndex=5&day=20100323&stop=1987&check1=on"
      criteria = {:location => 1987, :route_index => 1, :date => date}
      assert_equal expected, OCTranspo::MobileStopSchedule.url_for(criteria)
    end
    
    test "find schedule for route 1 going to South Keys from bus stop 8789 (the first stop on the route)" do
      criteria = {:route => 1, :direction => "SOUTH KEYS", :location => "8789", :date => date}
      schedule = OCTranspo::MobileStopSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,                       schedule[:date]
      assert_equal "8789",                     schedule[:location][:number]
      assert_equal "MAPLE LANE / SPRINGFIELD", schedule[:location][:name]
      assert_equal "1",                        schedule[:route]
      assert_equal "SOUTH KEYS",               schedule[:direction]
      
      assert schedule[:departures].any?
      assert schedule[:departures].all? {|d| d[:time].utc_offset === Time.current.utc_offset }, "Some departure times are not in the expected time zone"
      
      first_departure = schedule[:departures].first
      assert_equal date.at("05:52"), first_departure[:time]
      assert_equal "SOUTH KEYS", first_departure[:destination]
    
      last_departure = schedule[:departures].last
      assert_equal date.at("23:11"), last_departure[:time]
      assert_equal "SOUTH KEYS", last_departure[:destination]
    end
    
    test "find schedule for route 2 heading toward Bayshore from bus stop #1987" do
      criteria = {:route => 2, :direction => "BAYSHORE", :location => "1987", :date => date}
      schedule = OCTranspo::MobileStopSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,                     schedule[:date]
      assert_equal "1987",                   schedule[:location][:number]
      assert_equal "SOMERSET O-W / BRONSON", schedule[:location][:name]
      assert_equal "2",                      schedule[:route]
      assert_equal "BAYSHORE",               schedule[:direction]
      
      assert schedule[:departures].any?
      assert schedule[:departures].all? {|d| d[:time].utc_offset === Time.current.utc_offset }, "Some departure times are not in the expected time zone"
      
      first_departure = schedule[:departures].first
      assert_equal date.at('05:03'), first_departure[:time]
      assert_equal "BAYSHORE", first_departure[:destination]
      
      last_departure = schedule[:departures].last
      assert_equal date.next.at('01:18'), last_departure[:time]
      assert_equal "BAYSHORE", last_departure[:destination]
    end
    
    test "find schedule for route 3 heading toward Colonnade from bus stop #7558" do
      criteria = {:route => 3, :direction => "COLONNADE", :location => "7558", :date => date}
      schedule = OCTranspo::MobileStopSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,        schedule[:date]
      assert_equal "7558",      schedule[:location][:number]
      assert_equal "ELGIN / QUEEN", schedule[:location][:name]
      assert_equal "3",         schedule[:route]
      assert_equal "COLONNADE", schedule[:direction]
      
      assert schedule[:departures].any?
      assert schedule[:departures].all? {|d| d[:time].utc_offset === Time.current.utc_offset }, "Some departure times are not in the expected time zone"
      
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

    test "find the first schedule for stop number 1987" do
      criteria = {:location => 1987, :date => date}
      schedule = OCTranspo::MobileStopSchedule.find_one(criteria)
    
      assert_equal date, schedule[:date]
      assert_equal "2", schedule[:route]
      assert_equal "BAYSHORE", schedule[:direction]
      assert schedule[:legend]
      assert schedule[:destinations]
      assert schedule[:departures].any?
      
      first_departure = schedule[:departures].first
      assert_equal date.at("05:03"), first_departure[:time]
      assert_equal "BAYSHORE", first_departure[:destination]
      
      last_departure = schedule[:departures].last
      assert_equal date.next.at("01:18"), last_departure[:time]
      assert_equal "BAYSHORE", last_departure[:destination]
    end
    
    test "find all schedules for stop number 1987" do
      criteria = {:location => 1987, :date => date}
      schedules = OCTranspo::MobileStopSchedule.find_all(criteria)
      assert 2, schedules.size
      
      assert_equal "2",        schedules.first[:route]
      assert_equal "BAYSHORE", schedules.first[:direction]
      assert schedules.first[:departures].any?
      
      assert_equal "153",      schedules.last[:route]
      assert_equal "LEBRETON", schedules.last[:direction]
      assert schedules.last[:departures].any?
    end
    
    test "find schedule for route 404 going to scotia bank place from bus stop number 3058" do
      criteria = {:location => 3058, :route_index => 12, :date => date}
      schedule = OCTranspo::MobileStopSchedule.find_one(criteria)
      
      assert schedule
      assert_equal date,                             schedule[:date]
      assert_equal "404",                            schedule[:route]
      assert_equal "SCOTIABANK PLACE BANQUE SCOTIA", schedule[:direction]
      assert_equal "3058",                           schedule[:location][:number]
      assert_equal "TERRY FOX 3C",                   schedule[:location][:name]
      
      assert schedule[:departures].any?
    end
  end
end