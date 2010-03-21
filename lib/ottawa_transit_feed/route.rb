module OttawaTransitFeed
  class Route < Record

    extend Feeder

    feed_attributes :route_id, :route_type, :route_short_name, :route_long_name

    has_many :trips, :primary_key => :route_id
    
    serialize :stop_ids

    alias_attribute :number, :short_name
    alias_attribute :destination, :long_name

    before_validation :set_route_id
    before_validation :set_destination
  
    validates_presence_of :number, :heading, :stop_ids, :route_id, :destination
    
    class << self
      
      def save_all_records
        Route.all.each do |route|
          puts route.inspect
          route.save!
        end
      end
      
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
      if number.present? && destination.present?
        "#{number} #{destination}"
      else
        "#{number} [#{heading}]"
      end
    end

    def stops
      @stops ||= find_stops
    end
    
    protected
    
    def set_route_id
      if route_id.blank? && number.present? && heading.present? && stop_ids.present?
        self.route_id = self.class.identifier_for number, heading, stop_ids
      end
    end
    
    def set_destination
      if destination.blank?
        if headsign = find_headsign
          headsign_words = headsign.split " "
          self.number      = headsign_words.shift
          self.destination = headsign_words * " "
        end
      end
    end
    
    def find_headsign
      if number.present? && heading.present? && stops.present?
        OCTranspo::Headsign.find(number, heading, stops.map(&:attributes).each(&:symbolize_keys!))
      end
    end
    
    def find_stops
      if stop_ids.present?
        stop_ids.map { |stop_id| Stop.find_by_stop_id!(stop_id) }
      end
    end
  end
end