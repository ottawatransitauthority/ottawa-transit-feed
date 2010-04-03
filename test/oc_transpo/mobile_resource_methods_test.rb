require "#{File.dirname(File.dirname(__FILE__))}/test_helper"
require "oc_transpo"

module OCTranspo
  class MobileResourceMethodsTest < ActiveSupport::TestCase

    include MobileResourceMethods
    
    def date
      @date ||= Date.parse("20090303")
    end
    
    test "extracting time from text on a specific date" do
      assert_equal date.at('04:00'), extract_time_from("4:00 AM", :date => date)
      assert_equal date.at('06:30'), extract_time_from("6:30 AM", :date => date)
      assert_equal date.at('12:00'), extract_time_from("12:00 PM", :date => date)
      assert_equal date.at('15:30'), extract_time_from("3:30 PM", :date => date)
      assert_equal date.at('23:57'), extract_time_from("11:57 PM", :date => date)
      assert_equal date.next.at('02:30'), extract_time_from("2:30 AM", :date => date)
      assert_equal date.next.at('03:59'), extract_time_from("3:59 AM", :date => date)
    end
    
    test "extracting flags from text" do
    end
  end
end