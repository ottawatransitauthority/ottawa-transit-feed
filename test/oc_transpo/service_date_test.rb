require "#{File.dirname(File.dirname(__FILE__))}/test_helper"
require "oc_transpo"

module OCTranspo
  class ServiceDateTest < ActiveSupport::TestCase
    
    include ServiceDate
    
    test "service_date_for" do
      monday  = Date.parse('Monday, September 29')
      tuesday = Date.parse('Tuesday, September 30')
      
      monday_at_8_am      = Time.zone.parse("Monday, September 29 at 08:00")
      monday_at_noon      = Time.zone.parse("Monday, September 29 at 12:00")
      monday_at_11_pm     = Time.zone.parse("Monday, September 29 at 23:00")
      tuesday_at_midnight = Time.zone.parse("Tuesday, September 30 at 00:00")
      tuesday_at_3_am     = Time.zone.parse("Tuesday, September 30 at 03:00")
      tuesday_at_5_am     = Time.zone.parse("Tuesday, September 30 at 05:00")
      
      assert_equal monday,  service_date_for(monday_at_8_am)
      assert_equal monday,  service_date_for(monday_at_noon)
      assert_equal monday,  service_date_for(monday_at_11_pm)
      assert_equal monday,  service_date_for(tuesday_at_midnight)
      assert_equal monday,  service_date_for(tuesday_at_3_am)
      assert_equal tuesday, service_date_for(tuesday_at_5_am)
    end
  end
end