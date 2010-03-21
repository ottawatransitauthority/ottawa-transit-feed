$:.unshift 'lib'

require "ottawa_transit_feed"
require "test/unit"
require "active_support"
require "active_support/test_case"

OttawaTransitFeed.env = :test
OttawaTransitFeed.reset_database