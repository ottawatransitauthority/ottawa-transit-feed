require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class ExportTest < ActiveSupport::TestCase

    def setup
      system "rm -rf test/fixtures/transit_feeds/ottawa_transit_feed"
      system "mkdir -p test/fixtures/transit_feeds/ottawa_transit_feed"
      OttawaTransitFeed.clear_database
      OttawaTransitFeed.import "test/fixtures/transit_feeds/oc_transpo"
      OttawaTransitFeed.export "test/fixtures/transit_feeds/ottawa_transit_feed"
    end

    test "exported agencies" do 
      expected = [
        ['agency_id',  'agency_url',              'agency_name', 'agency_timezone',  'agency_phone', 'agency_lang'],
        ['OC Transpo', 'http://www.octranspo.com','OC Transpo',  'America/Montreal', '613-560-1000', 'EN'         ]
      ]
      assert_equal expected, exported(:agency)
    end
    
    test "exported calendar" do 
      expected = [
        ["service_id", "start_date", "end_date", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"],
        ["WEEKDAY_SCHEDULE",    "20090101", "20091231", "1", "1", "1", "1", "1", "0", "0"],
        ["SATURDAY_SCHEDULE",   "20090101", "20091231", "0", "0", "0", "0", "0", "1", "0"],
        ["SUNDAY_SCHEDULE",     "20090101", "20091231", "0", "0", "0", "0", "0", "0", "1"],
        ["LABOUR_DAY_SCHEDULE", "20090907", "20090907", "1", "0", "0", "0", "0", "0", "0"]
      ]
      assert_equal expected, exported(:calendar)
    end

    test "exported calendar dates" do 
      expected = [
        ["service_id",       "date",     "exception_type"],
        ["WEEKDAY_SCHEDULE", "20090907", "2"             ]
      ]
      assert_equal expected, exported(:calendar_dates)
    end
    
    test "exported routes" do 
      expected = [
        ["route_id",                         "route_type", "route_short_name", "route_long_name"],
        ["a5dfc1ee6580b9cbc956524560cba1f7", nil,          "1X",               "DOWNTOWN"       ]
      ]
      assert_equal expected, exported(:routes)
    end

    test "exported stops" do 
      expected = [
        ["stop_id", "stop_code", "stop_name",                      "stop_lat",  "stop_lon"  ],
        ["RF900",   "3037",      "Greenboro Station, Platform 1A", "45.360252", "-75.658859"],
        ["CD920",   "3009",      "Rideau Centre, Platform 3A",     "45.426365", "-75.691154"]
      ]
      assert_equal expected, exported(:stops)
    end
    
    test "exported stops_times" do 
      expected = [
        ["trip_id",              "stop_id", "stop_sequence", "arrival_time", "departure_time", "pickup_type", "drop_off_type"],
        ["001-WEEKDAY_SCHEDULE", "RF900",   "1",             "04:25:00",     "04:25:00",       "0",           "0"            ],
        ["001-WEEKDAY_SCHEDULE", "CD920",   "2",             "04:30:00",     "04:30:00",       "0",           "0"            ]
      ]
      assert_equal expected, exported(:stop_times)
    end
    
    test "exported tripe" do 
      expected = [
        ["service_id",       "block_id", "route_id",                         "trip_id"             ],
        ["WEEKDAY_SCHEDULE", "123",      "a5dfc1ee6580b9cbc956524560cba1f7", "001-WEEKDAY_SCHEDULE"]
      ]
      assert_equal expected, exported(:trips)
    end
    
    def exported (name)
      FasterCSV.parse IO.read("test/fixtures/transit_feeds/ottawa_transit_feed/#{name}.txt")
    end
  end
end