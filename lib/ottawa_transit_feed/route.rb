module OttawaTransitFeed
  class Route < Record

    extend Feeder

    feed_attributes :route_id, :route_type, :route_short_name, :route_long_name

    has_many :trips, :primary_key => :route_id
    
    serialize :stop_ids

    alias_attribute :number, :short_name
    alias_attribute :destination, :long_name

    before_validation :set_route_id
  
    validates_presence_of :number, :heading, :stop_ids, :route_id
    
    class << self
      def import (feed=nil)
        # Routes are created durring Trip.import
      end
      
      def identifier_for (number, heading, stop_ids)
        Digest::MD5.hexdigest "#{number} #{heading} #{stop_ids * '-'}"
      end
      
      def find_or_create! (number, heading, stop_ids)
        route = find_by_route_id(identifier_for(number, heading, stop_ids))
        unless route
          route = Route.new
          route.number   = number
          route.heading  = heading
          route.stop_ids = stop_ids
          route.save!
        end
        return route
      end
    end
    
    def headsign
      OCTranspo::Headsign.find(number, heading, stops.map(&:attributes).each(&:symbolize_keys!))
    end
    
    def stops
      stop_ids.map { |stop_id| Stop.find_by_stop_id!(stop_id) }
    end
    
    def set_route_id
      if route_id.blank? && number.present? && heading.present? && stop_ids.present?
        self.route_id = self.class.identifier_for number, heading, stop_ids
      end
    end
  end
end