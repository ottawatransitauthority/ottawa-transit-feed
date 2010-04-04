module OttawaTransitFeed
  module RouteMaintenance

    def import (feed=nil)
      # Routes are created durring Trip.import
    end

    def reset
      delete_all
      Trip.find_each do |trip|
        trip.route_id = trip.route_id
        trip.save!
      end
      :finished
    end
    
    def cleanup
      find_each do |route|
        route.destroy if route.trips.count.zero?
      end
      :finished
    end
  end
end