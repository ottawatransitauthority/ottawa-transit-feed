require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class RouteTest < ActiveSupport::TestCase
    
    def setup
      OttawaTransitFeed.clear_database
    end
    
    test "can’t validate route without route_id" do
      assert Route.new.invalid?
    end
  end
end
