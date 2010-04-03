require "rubygems"
gem "activesupport", "= 2.3.5"
gem "hpricot"

module OCTranspo
  autoload :Lingo,       "oc_transpo/lingo"
  autoload :ServiceDate, "oc_transpo/service_date"
  autoload :Stop,        "oc_transpo/stop"
  autoload :Headsign,    "oc_transpo/headsign"

  autoload :RemoteResourceMethods, "oc_transpo/remote_resource_methods"
  autoload :MobileResourceMethods, "oc_transpo/mobile_resource_methods"
  autoload :MobileRouteData,       "oc_transpo/mobile_route_data"
  autoload :MobileRouteSchedule,   "oc_transpo/mobile_route_schedule"
  autoload :MobileStopSchedule,    "oc_transpo/mobile_stop_schedule"
end