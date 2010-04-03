require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class CalendarTest < ActiveSupport::TestCase
    
    def setup
      OttawaTransitFeed.clear_database
    end
    
    test "4 calendars should be imported from fixtures" do 
      assert_difference "Calendar.count", +4 do
        Calendar.import "test/fixtures/transit_feeds/oc_transpo"
      end
    end
  end
end
