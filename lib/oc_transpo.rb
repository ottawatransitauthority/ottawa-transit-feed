require "rubygems"
gem "activesupport", "= 2.3.5"

module OCTranspo
  autoload :Lingo,       "oc_transpo/lingo"
  autoload :ServiceDate, "oc_transpo/service_date"
  autoload :Stop,        "oc_transpo/stop"
  autoload :Headsign,    "oc_transpo/headsign"
end