require "digest/md5"

module OttawaTransitFeed
  class Trip < Record

    extend Feeder

    feed_attributes :service_id, :block_id, :route_id, :trip_id

    belongs_to :route, :primary_key => :route_id

    has_many :stop_times, :primary_key => :trip_id, :order => :stop_sequence

    before_validation :set_route
  
    validates_presence_of :route_id, :service_id, :trip_id, :stop_ids
    
    def stop_ids
      StopTime.find_all_by_trip_id(trip_id, :order => :stop_sequence).map(&:stop_id)
    end
    
    def trip_headsign= (headsign)
      self.original_headsign = headsign
    end

    def route_id= (route_id)
      self.original_route_id = route_id
    end
    
    def route_number
      "#{original_route_id}".split('-').first.to_i
    end
    
    def route_heading
      original_headsign.upcase
    end
    
    protected

    def set_route
      if route.nil? && route_number.present? && route_heading.present? && stop_ids.present?
        self.route = Route.find_or_create!(route_number, route_heading, stop_ids)
      end
    end
  end
end
