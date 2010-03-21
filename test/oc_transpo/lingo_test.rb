require "#{File.dirname(File.dirname(__FILE__))}/test_helper"
require "oc_transpo"

module OCTranspo
  class LingoTest < ActiveSupport::TestCase

    include Lingo

    test "translate location lingo for addresses" do
      assert_equal "360 Coventry Rd.", translate_location("COVENTRY / AD. 360")
    end

    test "translate location lingo for addresses with back slashes" do
      assert_equal "1520 Caldwell Ave.", translate_location("CALDWELL \\ AD. 1520")
    end

    test "translate location lingo for intersections" do
      assert_equal "Somerset St. at Bronson Ave.", translate_location("SOMERSET O-W / BRONSON")
      assert_equal "Coventry Rd. at Jetform Park", translate_location("COVENTRY / PARC JETFORM PARK")
      assert_equal "Ballard Ct. at Blair Rd.", translate_location("BALLARD / BLAIR")
      assert_equal "Ballard Rd. at Blair Rd.", translate_location("NRC ROAD BALLARD / BLAIR")
      assert_equal "Blair Rd. at Meadowbrook Rd.", translate_location("BLAIR  / MEADOWBROOK")
      assert_equal "Broadview Ave. at Notre Dame High School", translate_location("BROADVIEW / É.S. NOTRE DAME")
      assert_equal "Bridgestone Dr. at Windways Crescent", translate_location("BRIDGESTONE / WINDWAYS")
      assert_equal "Eagleson Rd. at Cadence Gate", translate_location("EAGLESON / CADENCE")
      assert_equal "Shirley’s Brook Dr. at Marconi Ave.", translate_location("SHIRLEY'S BROOK / MARCONI")
      assert_equal "Stittsville Main St. at Bandelier Way", translate_location("MAIN STITTSVILLE / BANDELIER")
      assert_equal "Cyrville Rd. at Maxime St.", translate_location("CYRVILLE / MAXIME")
      assert_equal "Orléans Blvd. at Boyer Rd.", translate_location("ORLÉANS / BOYER")
      assert_equal "Lees Ave. at Main St.", translate_location("LEES / MAIN")
      assert_equal "Strandherd Dr. at Jockvale Rd.", translate_location("STRANDHERD / JOCKVALE")
      assert_equal "Jeanne d’Arc Blvd. at Terry Fox Elementary School", translate_location("JEANNE D'ARC / ÉCOLE TERRY FOX SCHOOL")
      assert_equal "Promenade Ave. at Terrasses de la Chaudière", translate_location("PROMENADE / TERRASSES DE LA CHAUDIÈRE")
      assert_equal "Scott St. at Bayview Rd.", translate_location("SCOTT / BAYVIEW")
    end
    
    test "translate location lingo for intersections with back slashes" do
      assert_equal "Ages Dr. at Hawthorne Rd.", translate_location("AGES \\ HAWTHORNE")
    end
    
    test "translate location lingo for stations" do
      assert_equal "Bayshore Station", translate_location("BAYSHORE")
      assert_equal "Baseline Station", translate_location("BASELINE")
      assert_equal "Blair Station", translate_location("BLAIR")
    end
    
    test "translate location lingo for busway platforms at stations" do
      assert_equal "Bayshore Station, Platform 1A", translate_location("BAYSHORE 1A")
      assert_equal "Baseline Station, Platform 1E", translate_location("BASELINE 1E")
      assert_equal "Lebreton Station, Platform 1A", translate_location("LEBRETON  1A")
      assert_equal "St. Laurent Station, Platform 2A", translate_location("ST LAURENT 2A")
      assert_equal "Tunney’s Pasture Station, Platform 1A", translate_location("TUNNEY'S PASTURE 1A")
    end
    
    test "translate location lingo for busway platforms at landmarks" do
      assert_equal "Rideau Centre, Platform 3A", translate_location("RIDEAU 3A")
      assert_equal "Rideau Centre, Platform 4A", translate_location("RIDEAU 4A")
    end
    
    test "translate location lingo for train platforms" do
      assert_equal "Bayview Station, O-Train Platform",   translate_platform("O-TRAIN BAYVIEW")
      assert_equal "Carleton Station, Southbound Platform", translate_platform("O-TRAIN CARLETON S.")
      assert_equal "Carleton Station, Northbound Platform", translate_platform("O-TRAIN CARLETON N.")
    end

    test "translate landmarks" do
      assert_equal "Colonnade Rd. at OC Transpo Garage", translate_location("MERIVALE GARAGE / GARAGE MERIVALE")
      assert_equal "Colonnade Rd. at OC Transpo Garage", translate_location("COLONNADE / GARAGE O.C. TRANSPO GARAGE")
    end

    test "translate locations in hull" do
      assert_equal "Rue Laurier at Rue Élisabeth-Bruyère", translate_location("LAURIER / ÉLISABETH-BRUYÈRE")
      assert_equal "Boulevard Des Allumettières at Rue Laurier", translate_location("ALLUMETTIÈRES / LAURIER")
    end

    test "translate broken lingo" do
      assert_equal "Tunney’s Pasture Station, Platform 4A", translate_location("TUNNEY'S PASTURE4A")
      assert_equal "Heron Station, Platform 4A", translate_location("HERON 4A ")
      assert_equal "Heron Rd. at Edge Hill Pl.", translate_location("HERON/EDGEHILL")
      assert_equal "Dauphin Rd. at Hillcrest High School", translate_location("NODE4518")
      assert_equal "Campus Ave. at Library Rd.", translate_location("CAMPUS / COMMONS")
    end

    test "recognize lingo that represents an address" do
      assert address?("COVENTRY / AD. 360")
      assert ! address?("SOMERSET O-W / BRONSON")
      assert ! address?("BAYSHORE")
      assert ! address?("BAYSHORE 1A")
    end
    
    test "recognize lingo that represents an intersection" do
      assert intersection?("SOMERSET O-W / BRONSON")
      assert ! intersection?("COVENTRY / AD. 360")
      assert ! intersection?("BAYSHORE")
      assert ! intersection?("BAYSHORE 1A")
    end
    
    test "recognize lingo that represents a platform" do
      assert platform?("BAYSHORE 1A")
      assert ! platform?("SOMERSET O-W / BRONSON")
      assert ! platform?("COVENTRY / AD. 360")
      assert ! platform?("BAYSHORE")
    end

    test "extract address parts from lingo" do
      extracted = extract_address_from("COVENTRY / AD. 360")
      assert_equal "360", extracted[:number]
      assert_equal "COVENTRY", extracted[:street]
    end
    
    test "extract intersection parts from lingo" do
      extracted = extract_intersection_from("SOMERSET O-W / BRONSON")
      assert_equal "SOMERSET O-W", extracted.first
      assert_equal "BRONSON", extracted.last
    end

    test "extract platform parts from lingo" do
      extracted = extract_platform_from("BAYSHORE 1A")
      assert_equal "BAYSHORE", extracted[:station]
      assert_equal "1A", extracted[:platform]
    end

    test "extract platform parts from lingo with two word station name" do
      extracted = extract_platform_from("BILLINGS BRIDGE 1A")
      assert_equal "BILLINGS BRIDGE", extracted[:station]
      assert_equal "1A", extracted[:platform]
    end

    test "extract platform parts from lingo with extra space" do
      extracted = extract_platform_from("LEBRETON  1A")
      assert_equal "LEBRETON", extracted[:station]
      assert_equal "1A", extracted[:platform]
    end
  end
end