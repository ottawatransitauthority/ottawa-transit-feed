module OttawaTransitFeed
  class StopTime < Record

    extend Feeder

    feed_attributes :trip_id, :stop_id, :stop_sequence, :arrival_time, :departure_time, :pickup_type, :drop_off_type
    
    validates_presence_of :trip_id, :stop_id, :stop_sequence, :arrival_time, :departure_time

    belongs_to :stop, :primary_key => :stop_id
    belongs_to :trip, :primary_key => :trip_id
    
    def timestamp= (time)
      self.arrival_time   = time
      self.departure_time = time
    end
  end
end