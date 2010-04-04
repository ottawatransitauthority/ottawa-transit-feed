module OttawaTransitFeed
  class Route < Record
    extend Feeder
    extend RouteFunctions
    extend RouteMaintenance

    feed_attributes :route_id, :route_type, :route_short_name, :route_long_name

    validates_presence_of :route_id, :route_type, :short_name, :long_name
    
    has_many :trips,     :primary_key => :route_id
    has_many :headsigns, :primary_key => :route_id
    
    serialize :stop_ids

    before_validation :set_route_type

    def number
      route_id.to_i
    end
    
    def short_name
      route_id
    end

    protected
    
    def set_route_type
      self.route_type = 2 # TODO, account for O-Train
    end
  end
end