require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class RouteTest < ActiveSupport::TestCase
    
    def setup
      OttawaTransitFeed.clear_database
    end
    
    test "can’t validate route without number" do
      origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
      destination = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"

      assert Route.new(:heading => "OTTAWA-ROCKCLIFFE", :stop_ids => [origin.stop_id, destination.stop_id]).invalid?
    end

    test "can’t validate route without a heading" do
      origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
      destination = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"

      assert Route.new(:number => 1, :stop_ids => [origin.stop_id, destination.stop_id]).invalid?
    end

    test "can’t validate route without stops" do
      origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
      destination = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"

      assert Route.new(:number => 1, :heading => "OTTAWA-ROCKCLIFFE").invalid?
    end
    
    test "can’t validate route with empty array of stops" do
      origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
      destination = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"

      assert Route.new(:number => 1, :heading => "OTTAWA-ROCKCLIFFE", :stop_ids => []).invalid?
    end
    
    test "set headsign of a 1 OTTAWA-ROCKCLIFFE route" do
      origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
      destination = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"
      
      route = Route.create! do |route|
        route.number   = 1
        route.heading  = "OTTAWA-ROCKCLIFFE"
        route.stop_ids = [origin.stop_id, destination.stop_id]     
      end
      
      assert_equal "1", route.number
      assert_equal "OTTAWA ROCKCLIFFE", route.destination
      assert_equal "1 OTTAWA ROCKCLIFFE", route.headsign
    end
    
    test "set headsign of a 1X DOWNTOWN route" do
      origin      = Stop.create! :name => "GREENBORO 1A", :stop_id => "RF900"    
      destination = Stop.create! :name => "RIDEAU 3A", :stop_id => "CD920"

      route = Route.create! do |route|
        route.number   = 1
        route.heading  = "OTTAWA ROCKCLIFFE"
        route.stop_ids = [origin.stop_id, destination.stop_id]        
      end
      
      assert_equal "1X", route.number
      assert_equal "DOWNTOWN", route.destination
      assert_equal "1X DOWNTOWN", route.headsign
    end
    
    test "set headsign of a 1 SOUTH KEYS route" do
      origin      = Stop.create! :name => "MAPLE LANE / SPRINGFIELD", :stop_id => "AA380"
      destination = Stop.create! :name => "GREENBORO 1B", :stop_id => "RF905"
      
      route = Route.create! do |route|
        route.number   = 1
        route.heading  = "SOUTH KEYS"
        route.stop_ids = [origin.stop_id, destination.stop_id]        
      end

      assert_equal "1", route.number
      assert_equal "SOUTH KEYS", route.destination
      assert_equal "1 SOUTH KEYS", route.headsign
    end
    
    test "setting the headsign of a 2 BAYSHORE route" do
      origin      = Stop.create! :name => "RIDEAU 4A", :stop_id => "CD935"
      destination = Stop.create! :name => "BAYSHORE 3A", :stop_id => "WD940"

      route = Route.create! do |route|
        route.number   = 2
        route.heading  = "BAYSHORE"
        route.stop_ids = [origin.stop_id, destination.stop_id]        
      end

      assert_equal "2", route.number
      assert_equal "BAYSHORE", route.destination
      assert_equal "2 BAYSHORE", route.headsign
    end
    
    test "setting the headsign of a 2 WESTBORO headsign" do
      origin      = Stop.create! :name => "RIDEAU 4A", :stop_id => "CD935"
      destination = Stop.create! :name => "WESTBORO 3A", :stop_id => "NC950"
      
      route = Route.create! do |route|
        route.number   = 2
        route.heading  = "BAYSHORE"
        route.stop_ids = [origin.stop_id, destination.stop_id]        
      end

      assert_equal "2", route.number
      assert_equal "WESTBORO", route.destination
      assert_equal "2 WESTBORO", route.headsign
    end
    
    test "setting the headsign of a 2 DOWNTOWN headsign" do
      origin      = Stop.create! :name => "BAYSHORE 4B", :stop_id => "WD960"
      destination = Stop.create! :name => "RIDEAU 3A", :stop_id => "CD920"
      
      route = Route.create! do |route|
        route.number   = 2
        route.heading  = "DOWNTOWN / CENTRE-VILLE"
        route.stop_ids = [origin.stop_id, destination.stop_id]        
      end

      assert_equal "2", route.number
      assert_equal "DOWNTOWN", route.destination
      assert_equal "2 DOWNTOWN", route.headsign
    end
  end
end
