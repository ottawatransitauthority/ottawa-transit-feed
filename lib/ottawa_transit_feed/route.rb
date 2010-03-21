module OttawaTransitFeed
  class Route < Record

    extend Feeder

    feed_attributes :route_id, :route_type, :route_short_name, :route_long_name

    has_many :trips, :primary_key => :route_id
    
    serialize :stop_ids

    before_validation :set_route_type
    before_validation :set_short_name
  
    validates_presence_of :route_id, :route_type, :short_name

    def number
      route_id.to_i
    end
    
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
      
      def find_or_create! (route_id)
        if route = find_by_route_id(route_id)
          return route
        else
          route = new(:route_id => route_id)
          route.save!
          return route
        end
      end
    end

    protected
    
    def set_route_type
      self.route_type = 2 # TODO, account for O-Train
    end
    
    def set_short_name
      if short_name.blank?
        self.short_name = route_id.to_s
      end
    end
  end
end