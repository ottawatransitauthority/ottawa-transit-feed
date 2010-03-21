require "#{File.dirname(File.dirname(__FILE__))}/test_helper"

module OttawaTransitFeed
  class StopTest < ActiveSupport::TestCase

    test "stops preserve their originally assigned names" do 
      stop = Stop.new :stop_name => "SOUTH KEYS"
      assert_equal "SOUTH KEYS", stop.original_name
    end
    
    test "name of bus stop at address" do
      stop = Stop.new :stop_name => "COVENTRY / AD. 360"
      assert_equal "360 Coventry Rd.", stop.name
    end

    test "name of bus stop at intersection" do 
      stop = Stop.new :stop_name => "BRONSON / SOMERSET"
      assert_equal "Bronson Ave. at Somerset St.", stop.name
    end

    test "name of bus platform at station" do
      stop = Stop.new :stop_name => "BLAIR 3A"
      assert_equal "Blair Station, Platform 3A", stop.name
    end
    
    test "name of bus platform at landmark" do
      stop = Stop.new :stop_name => "RIDEAU 3A"
      assert_equal "Rideau Centre, Platform 3A", stop.name
    end

    test "name of train platform at station" do
      stop = Stop.new :stop_name => "O-TRAIN BAYVIEW"
      assert_equal "Bayview Station, O-Train Platform", stop.name
    end
    
    test "code for known stop_id" do 
      stop = Stop.new :stop_id => "CI335"
      assert_equal "1987", stop.code
    end

    test "code is nil when stop_id is unknown" do 
      stop = Stop.new :stop_id => "UNKNOWN"
      assert_nil stop.code
    end
  end
end
