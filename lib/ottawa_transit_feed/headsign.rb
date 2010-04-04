require "oc_transpo"

module OttawaTransitFeed
  class Headsign < Record
    extend HeadsignFunctions
    
    validates_presence_of :route_id, :stop_ids, :signature
    
    belongs_to :route, :foreign_key => :route_id, :primary_key => :route_id
    
    has_many :trips, :foreign_key => :headsign_signature, :primary_key => :signature
    
    before_validation :set_signature
    
    serialize :stop_ids

    named_scope :all_missing_strings, :conditions => {:string => nil}

    def stops
      stop_ids.map do |stop_id|
        Stop.find_by_stop_id stop_id
      end
    end
    
    def message
      /\d+ (.*)/.match(string)[1]
    end
    
    def set_signature
      self.signature = Headsign.signature_for route, stop_ids
    end
    
    def set_string
      if message = find_message
        self.string = "#{route.number} #{message}"
      end
    end
    
    def find_message
      trips.each do |trip|
        if message = find_message_by_trip(trip)
          return message
        end
      end
    end
    
    def find_message_by_trip (trip)
      if departure = trip.find_remote_departure
        return departure[:destination]
      end
    end
  end
end