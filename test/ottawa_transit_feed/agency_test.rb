require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class AgencyTest < ActiveSupport::TestCase

    def agency_text
      Agency.import! "test/fixtures/transit_feeds/oc_transpo"
      Agency.export "test/fixtures/transit_feeds/ottawa_transit_feed"
      IO.read("test/fixtures/transit_feeds/ottawa_transit_feed/agency.txt")
    end
    
    test "exported agency file includes name of OC Transpo" do 
      assert_match "OC Transpo", agency_text
    end

    test "exported agency file includes URL for OC Transpo" do 
      assert_match "http://www.octranspo.com", agency_text
    end

    test "exported agency file includes telephone number for OC Transpo" do 
      assert_match "613-560-1000", agency_text
    end
  end
end