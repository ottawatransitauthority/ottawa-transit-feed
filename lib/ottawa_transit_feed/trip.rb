require "digest/md5"

module OttawaTransitFeed
  class Trip < Record
    extend Feeder
    
    # Trips travel along a route. Thay make several stops along the way picking up passengers and dropping
    # them off. Operators are expected to drive the trip according to it’s scheduled stop times.
    #
    # Trips are primarily a scheduling association that provide these core attributes:
    #
    #   trip.calendar => A schedule that defines the period of time when the trip is operated.
    #   trip.headsign => A headsign that can be matched to the signage on a service vehicle.
    #   trip.route    => Provides the route number and name of the trip.
    #   trip.moments  => Ordered list moments in the trip. Each moment provides an arrival and departure time and a stop id.
    #   trip.stops    => Ordered list of stop locations in the trip.
    #

    feed_attributes :service_id, :block_id, :route_id, :trip_id

    validates_presence_of :service_id, :trip_id, :route
    
    belongs_to :calendar, :foreign_key => "service_id"
    belongs_to :route,    :foreign_key => "route_id",           :primary_key => "route_id"
    belongs_to :headsign, :foreign_key => "headsign_signature", :primary_key => "signature"
    
    has_many :stop_times, :primary_key => "trip_id", :order => "stop_sequence"

    alias :moments :stop_times
    
    named_scope :all_missing_headsigns, :conditions => {:headsign_signature => nil}
    
    def route_id= (route_id)
      self.original_route_id = route_id
      super Route.find_or_create!(route_id).route_id
    end
    
    def trip_headsign= (trip_headsign)
      self.original_headsign = trip_headsign
    end

    def stops
      Stop.find stop_ids
    end
    
    def stop_ids
      moments.map &:stop_id
    end
    
    def route_heading
      original_headsign.upcase
    end
  end
end
