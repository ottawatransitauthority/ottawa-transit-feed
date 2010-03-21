require "#{File.dirname(File.dirname(__FILE__))}/test_helper"
require "oc_transpo"

module OCTranspo
  class HeadsignTest < ActiveSupport::TestCase
    
    test "1 OTTAWA ROCKCLIFFE headsign" do
      assert_equal "1 OTTAWA ROCKCLIFFE", OCTranspo::Headsign.find(1, "OTTAWA-ROCKCLIFFE", [{:code => "8789"}])
    end

    test "1X DOWNTOWN headsign" do
      assert_equal "1 DOWNTOWN", OCTranspo::Headsign.find(1, "OTTAWA-ROCKCLIFFE", [{:code => "3009"}])
    end

    test "1 SOUTH KEYS headsign" do
      assert_equal "1 SOUTH KEYS", OCTranspo::Headsign.find(1, "SOUTH KEYS", [{:code => "3037"}])
    end

    test "1X BILLINGS BRIDGE headsign" do
      assert_equal "1X BILLINGS BRIDGE", OCTranspo::Headsign.find(1, "SOUTH KEYS", [{:code => "3034"}])
    end

    test "2 BAYSHORE headsign" do
      assert_equal "2 BAYSHORE", OCTranspo::Headsign.find(2, "BAYSHORE", [{:code => "3050"}])
    end

    test "2 WESTBORO headsign" do
      assert_equal "2 WESTBORO", OCTranspo::Headsign.find(2, "BAYSHORE", [{:code => "3012"}])
    end

    test "2 DOWNTOWN headsign" do
      assert_equal "2 DOWNTOWN", OCTranspo::Headsign.find(2, "DOWNTOWN", [{:code => "3009"}])
    end
  end
end