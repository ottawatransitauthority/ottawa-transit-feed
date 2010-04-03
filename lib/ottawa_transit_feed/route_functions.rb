require "oc_transpo"

module OttawaTransitFeed
  module RouteFunctions
  
    def save_all_records
      all.each do |route|
        puts route.inspect
        route.save!
      end
    end
  
    def import (feed=nil)
      # Routes are created durring Trip.import
    end
  
    def find_or_create! (original_route_id)
      route_data = OCTranspo::Route.find_by_route_id(original_route_id)
      if route = find_by_route_id(route_data[:number])
        return route
      else
        create! :route_id => route_data[:number], :long_name => route_data[:name]
      end
    end
  end
end