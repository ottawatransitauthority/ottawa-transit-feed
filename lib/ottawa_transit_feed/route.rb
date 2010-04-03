module OttawaTransitFeed
  class Route < Record

    extend Feeder

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
    
    class << self
      
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

    protected
    
    def set_route_type
      self.route_type = 2 # TODO, account for O-Train
    end
  end
end