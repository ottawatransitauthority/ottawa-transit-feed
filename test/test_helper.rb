$:.unshift 'lib'

require "ottawa_transit_feed"
require "test/unit"
require "active_support"
require "active_support/test_case"

OttawaTransitFeed.env = :test
OttawaTransitFeed.reset_database

class Date
  
  # date.at('12:00') => time object representing the date at noon
  def at (string)
    matches  = /^(\d\d)(:)*(\d\d)$/.match(string)
    hh, mm   = Integer(matches[1]), Integer(matches[3])
    duration = hh.hours + mm.minutes
    to_time.in_time_zone.change :hour => hh, :min => mm
  end
end