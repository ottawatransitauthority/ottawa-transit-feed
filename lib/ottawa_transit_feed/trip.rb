require "digest/md5"

module OttawaTransitFeed
  class Trip < Record

    extend Feeder

    feed_attributes :service_id, :block_id, :route_id, :trip_id

    belongs_to :route, :primary_key => :route_id, :class_name => Route.name

    has_many :stop_times, :primary_key => :trip_id, :order => :stop_sequence

    before_validation :set_route
    before_validation :set_headsign
  
    validates_presence_of :route, :service_id, :trip_id, :stops
    
    def stop_ids
      stops.map(&:stop_id)
    end
    
    def stops
      @stops ||= StopTime.find_all_by_trip_id(trip_id, :order => :stop_sequence).map(&:stop)
    end
        
    def route_id= (route_id)
      self.original_route_id = route_id.to_s
      super route_id.to_s.split('-').first
    end
    
    def trip_headsign= (headsign)
      self.original_headsign = headsign
    end

    def route_heading
      original_headsign.upcase
    end
    
    protected

    def set_route
      if route.blank? && route_id.present? && route_heading.present? && stop_ids.present?
        self.route = OttawaTransitFeed::Route.find_or_create!(route_id)
      end
    end
    
    def set_headsign
      if headsign.blank? && route.present? && route_heading.present? && stops.present?
        self.headsign = OCTranspo::Headsign.find(route.number, route_heading, stops.map(&:attributes).each(&:symbolize_keys!))
      end
    end
  end
end
